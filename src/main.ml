open Js_of_ocaml
module Html = Dom_html

type cell =
  | Empty
  | Shined
  | Filled of int
  | Light

type board = cell list list

let js = Js.string
let doc = Html.document

let demo_board =
  [
    [ Empty; Empty; Empty; Empty; Empty; Filled 1; Empty; Empty; Empty; Empty ];
    [ Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty ];
    [
      Empty; Empty; Filled 4; Empty; Empty; Empty; Filled 1; Empty; Empty; Empty;
    ];
    [ Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty ];
    [ Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty ];
    [
      Filled 1; Empty; Empty; Empty; Empty; Empty; Empty; Filled 3; Empty; Empty;
    ];
    [ Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty ];
    [
      Empty; Empty; Empty; Empty; Filled 2; Empty; Empty; Empty; Filled 1; Empty;
    ];
    [ Empty; Empty; Empty; Empty; Empty; Empty; Filled 1; Empty; Empty; Empty ];
    [ Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty ];
  ]

let cell_shined board x y =
  let rec check x' y' (dx, dy) =
    if x' < 0 || y' < 0 || x' >= List.length board || y' >= List.length board
    then false
    else
      match List.nth (List.nth board y') x' with
      | Empty -> check (x' + dx) (y' + dy) (dx, dy)
      | Light -> true
      | _ -> false
  in
  let checkdir (dx, dy) = check (x + dx) (y + dy) (dx, dy) in
  checkdir (1, 0) || checkdir (-1, 0) || checkdir (0, 1) || checkdir (0, -1)

let shined board =
  List.mapi
    (fun y ->
      List.mapi (fun x cell ->
          match cell with
          | Empty -> if cell_shined board x y then Shined else Empty
          | a -> a))
    board

let filled board =
  List.fold_left
    (fun acc (y, row) ->
      acc
      && List.fold_left
           (fun acc (x, cell) ->
             acc
             &&
             match cell with
             | Empty -> cell_shined board x y
             | Light -> Bool.not (cell_shined board x y)
             | Filled n ->
                 let check (dx, dy) =
                   let x' = x + dx in
                   let y' = y + dy in
                   if
                     x' < 0 || y' < 0
                     || x' >= List.length board
                     || y' >= List.length board
                   then 0
                   else
                     match List.nth (List.nth board y') x' with
                     | Light -> 1
                     | _ -> 0
                 in
                 check (1, 0) + check (-1, 0) + check (0, 1) + check (0, -1)
                 == n
             | _ -> true)
           true
           (List.mapi (fun i a -> (i, a)) row))
    true
    (List.mapi (fun i a -> (i, a)) board)

let div className =
  let div = Html.createDiv doc in
  div##.className := js className;
  div

let dom_of_board cb board =
  let els =
    List.mapi
      (fun y ->
        List.mapi (fun x cell ->
            let el =
              match cell with
              | Empty -> div "empty"
              | Shined -> div "shined"
              | Filled n ->
                  let el = div "filled" in
                  el##.innerText := js (string_of_int n);
                  el
              | Light -> div "light"
            in
            el##.onclick :=
              Html.handler (fun _ ->
                  cb board x y;
                  Js._true);
            el))
      (shined board)
  in
  let grid = div "grid" in
  let _ =
    Js.Unsafe.meth_call grid##.style "setProperty"
      [|
        Js.Unsafe.inject (js "--size");
        Js.Unsafe.inject (js (string_of_int (List.length board)));
      |]
  in
  List.iter (Dom.appendChild grid) (List.flatten els);
  grid

let click board x y =
  List.mapi
    (fun y' ->
      List.mapi (fun x' cell ->
          if x' = x && y' = y then
            match cell with
            | Empty -> Light
            | Light -> Empty
            | a -> a
          else cell))
    board

let game board =
  let root = div "game" in
  let rec update_board board x y =
    let board' = click board x y in
    let els = [| Js.Unsafe.inject (dom_of_board update_board board') |] in
    let els =
      if filled board' then Array.append [| Js.Unsafe.inject (div "done") |] els
      else els
    in
    let _ = Js.Unsafe.meth_call root "replaceChildren" els in
    ()
  in
  let _ = Dom.appendChild root (dom_of_board update_board board) in
  root
