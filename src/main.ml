open Util

type cell =
  | Empty
  | Filled of int
  | Light
  | Shined

type board = cell array array

let empty_board a b : board =
  Array.init a (fun _ -> Array.init b (fun _ -> Empty))

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

let shined (board : board) =
  board
  |> Array.mapi (fun y ->
         Array.mapi (fun x cell ->
             match cell with
             | Shined | Empty -> if cell_shined board x y then Shined else Empty
             | Light -> Light
             | Filled n -> Filled n))

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
             | Shined | Empty -> cell_shined board x y
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

let dom_of_cell cb board x y =
  let el =
    match board.(y).(x) with
    | Shined -> div "shined"
    | Empty -> div "empty"
    | Filled n ->
        let el = div "filled" in
        el##.innerText := js (string_of_int n);
        el
    | Light ->
        let elt = div "light" in
        Dom.appendChild elt @@ div "inner";
        elt
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

let game board =
  let root = div "game" in
  let grid = div "grid" in
  let status = div "playing" in
  Dom.appendChild root status;
  Dom.appendChild root grid;
  set_css grid "size" (string_of_int (Array.length board));
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
        Array.mapi (fun x cell ->
            dom_of_cell update_board shined_board x y))
      board
  in
  Array.iter (Dom.appendChild grid) (flat els);
  root
