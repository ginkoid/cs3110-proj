open Js_of_ocaml
module Html = Dom_html

type cell =
  | Empty
  | Filled of int
  | Light
  | Shined

type board = cell array array

type colstr = {col: int; str: string}

let colstr_of_tuple = function
  | (col, str) -> {col; str}

type theme = {
  background : colstr;
  empty : colstr;
  shined : colstr;
  light : colstr;
  block : int;
  }
  
  let js = Js.string
  let doc = Html.document
  
  let empty_board a b : board =
    Array.init a (fun _ -> Array.init b (fun _ -> Empty))
  
  let demo_theme_light = {
    background = colstr_of_tuple (0xeeeeee, " ");
    empty = colstr_of_tuple (0xffffff, " ");
    shined = colstr_of_tuple (0xc0ff7f, " ");
    light = colstr_of_tuple (0x027f60, "🧔");
    block = 0
  }

let demo_theme_dark = {
  background = colstr_of_tuple (0x111111, " ");
  empty = colstr_of_tuple (0x222222, " ");
  shined = colstr_of_tuple (0x027f60, " ");
  light = colstr_of_tuple (0xc0ff7f, " ");
  block = 0xeeeeee;
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

let div ?(innertext = "") className =
  let div = Html.createDiv doc in
  div##.className := js className;
  div##.innerText := js innertext;
  div

let dom_of_cell cb board theme x y =
  let el =
    match board.(y).(x) with
    | Shined -> div "shined" ~innertext:theme.shined.str
    | Empty -> div "empty" ~innertext:theme.empty.str
    | Filled n ->
        let el = div "filled" in
        el##.innerText := js (string_of_int n);
        el
    | Light -> let elt = div "light"
    in let eltinner = div "inner" ~innertext:theme.light.str
    in
    elt##.innerHTML := eltinner##.outerHTML;
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

let compare (a : cell) (b : cell) =
  match b with
  | Empty -> a == Empty
  | Filled n -> (
      match a with
      | Filled n' -> n == n'
      | _ -> false)
  | Light -> a == Light
  | Shined -> a == Shined

let hex_of_int n =
  Printf.sprintf "#%06x" n

let dom_of_board board theme =
  let root = div "game" in
  let grid = div "grid" in
  let status = div "playing" in
  let set_theme_col name colstr = 
    ignore @@ Js.Unsafe.meth_call grid##.style "setProperty"
         [|
           Js.Unsafe.inject (js ("--theme_" ^ name));
           Js.Unsafe.inject (js (hex_of_int colstr.col));
         |];
  in
  Dom.appendChild root status;
  Dom.appendChild root grid;
  let _ =
    ignore
    @@ Js.Unsafe.meth_call grid##.style "setProperty"
         [|
           Js.Unsafe.inject (js "--size");
           Js.Unsafe.inject (js (string_of_int (Array.length board)));
         |];
         set_theme_col "background" theme.background;
         set_theme_col "empty" theme.empty;
         set_theme_col "shined" theme.shined;
         set_theme_col "light" theme.light;
         set_theme_col "block" @@ colstr_of_tuple (theme.block, "");
  in
  let board' = ref board in
  let rec update_board x y =
    let board'' = click !board' x y in
    let shined_board'' = shined board'' in
    Array.iter2
      (fun (i, a) b ->
        (if not (compare a b) then
         let el =
           Js.Opt.get (grid##.childNodes##item i) (fun () -> assert false)
         in
         let el' =
           dom_of_cell update_board shined_board'' theme
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
        Array.mapi (fun x cell -> dom_of_cell update_board shined_board theme x y))
      board
  in
  Array.iter (Dom.appendChild grid) (flat els);
  root
