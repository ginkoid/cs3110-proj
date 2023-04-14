open Js_of_ocaml
module Html = Dom_html

type shined_cell =
  | Empty
  | Filled of int
  | Light
  | Shined

type cell =
  | Empty
  | Filled of int
  | Light

type board = cell array array

let js = Js.string
let doc = Html.document

type style = { color : int }

type theme = {
  background : style;
  empty : style;
  shined : style;
  light : style;
  block : style;
}

let theme_light =
  {
    background = { color = 0xeeeeee };
    empty = { color = 0xffffff };
    shined = { color = 0xc0ff7f };
    light = { color = 0x027f60 };
    block = { color = 0x000000 };
  }

let theme_dark =
  {
    background = { color = 0x111111 };
    empty = { color = 0x222222 };
    shined = { color = 0x027f60 };
    light = { color = 0xc0ff7f };
    block = { color = 0xeeeeee };
  }

let demo_board =
  [|
    [|
      Empty; Empty; Empty; Empty; Empty; Filled 1; Empty; Empty; Empty; Empty;
    |];
    [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
    [|
      Empty; Empty; Filled 4; Empty; Empty; Empty; Filled 1; Empty; Empty; Empty;
    |];
    [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
    [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
    [|
      Filled 1; Empty; Empty; Empty; Empty; Empty; Empty; Filled 3; Empty; Empty;
    |];
    [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
    [|
      Empty; Empty; Empty; Empty; Filled 2; Empty; Empty; Empty; Filled 1; Empty;
    |];
    [|
      Empty; Empty; Empty; Empty; Empty; Empty; Filled 1; Empty; Empty; Empty;
    |];
    [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
  |]

let cell_shined board x y =
  let rec check x' y' (dx, dy) =
    if x' < 0 || y' < 0 || x' >= Array.length board || y' >= Array.length board
    then false
    else
      match board.(y').(x') with
      | Empty -> check (x' + dx) (y' + dy) (dx, dy)
      | Light -> true
      | _ -> false
  in
  let checkdir (dx, dy) = check (x + dx) (y + dy) (dx, dy) in
  checkdir (1, 0) || checkdir (-1, 0) || checkdir (0, 1) || checkdir (0, -1)

let shined board =
  Array.mapi
    (fun y ->
      Array.mapi (fun x cell ->
          match cell with
          | Empty -> if cell_shined board x y then Shined else Empty
          | Light -> Light
          | Filled n -> Filled n))
    board

let indices a = Array.mapi (fun i a -> (i, a)) a

let filled board =
  Array.fold_left
    (fun acc (y, row) ->
      acc
      && Array.fold_left
           (fun acc (x, cell) ->
             acc
             &&
             match cell with
             | Empty -> cell_shined board x y
             | Light -> not (cell_shined board x y)
             | Filled n ->
                 let check (dx, dy) =
                   let x' = x + dx in
                   let y' = y + dy in
                   if
                     x' < 0 || y' < 0
                     || x' >= Array.length board
                     || y' >= Array.length board
                   then 0
                   else
                     match board.(y').(x') with
                     | Light -> 1
                     | _ -> 0
                 in
                 check (1, 0) + check (-1, 0) + check (0, 1) + check (0, -1)
                 == n)
           true (indices row))
    true (indices board)

let div className =
  let div = Html.createDiv doc in
  div##.className := js className;
  div

let dom_of_cell cb board x y =
  let el =
    match board.(y).(x) with
    | Shined -> div "shined"
    | Empty -> div "empty"
    | Filled n ->
        let el = div "filled" in
        el##.innerText := js (string_of_int n);
        el
    | Light -> div "light"
  in
  el##.onclick :=
    Html.handler (fun _ ->
        cb x y;
        Js._true);
  el

let flat a = Array.concat (Array.to_list a)

let click board x y =
  Array.mapi
    (fun y' ->
      Array.mapi (fun x' cell ->
          if x' = x && y' = y then
            match cell with
            | Empty -> Light
            | Light -> Empty
            | a -> a
          else cell))
    board

let hex_of_int n = Printf.sprintf "#%06x" n

let game theme board =
  let root = div "game" in
  let grid = div "grid" in
  let status = div "playing" in
  Dom.appendChild root status;
  Dom.appendChild root grid;
  let set_css name value =
    ignore @@ Js.Unsafe.meth_call grid##.style "setProperty"
      [| Js.Unsafe.inject (js ("--" ^ name)); Js.Unsafe.inject (js value) |]
  in
  let set_theme name value = set_css ("color-" ^ name) (hex_of_int value.color) in
  set_theme "background" theme.background;
  set_theme "empty" theme.empty;
  set_theme "shined" theme.shined;
  set_theme "light" theme.light;
  set_theme "block" theme.block;
  set_css "size" (string_of_int (Array.length board));
  let board' = ref board in
  let rec update_board x y =
    let board'' = click !board' x y in
    let shined_board'' = shined board'' in
    Array.iter2
      (fun (i, a) b ->
        (if a <> b then
         let el =
           Js.Opt.get (grid##.childNodes##item i) (fun () -> assert false)
         in
         let el' =
           dom_of_cell update_board shined_board''
             (i mod Array.length board)
             (i / Array.length board)
         in
         Dom.replaceChild grid el' el);
        ())
      (indices (flat (shined !board')))
      (flat shined_board'');
    status##.className := js (if filled board'' then "done" else "playing");
    board' := board''
  in
  let shined_board = shined board in
  let els =
    Array.mapi
      (fun y ->
        Array.mapi (fun x cell -> dom_of_cell update_board shined_board x y))
      board
  in
  Array.iter (Dom.appendChild grid) (flat els);
  root
