open Common
open Util

let shined (board : board) =
  board
  |> Array.mapi (fun y ->
         Array.mapi (fun x cell ->
             match cell with
             | Shined | Empty -> if cell_shined board x y then Shined else Empty
             | Light -> Light
             | Filled n -> Filled n))

let indices a = Array.mapi (fun i a -> (i, a)) a

let dom_of_cell cb board x y =
  let el =
    match board.(y).(x) with
    | Shined -> div "shined"
    | Empty -> div "empty"
    | Filled n -> div "filled" ?innertext:(Some (string_of_int n))
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
            | Shined | Empty -> Light
            | Light -> Empty
            | x -> x
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
      (enumerate (flat (shined !board')))
      (flat shined_board'');
    status##.className :=
      js (if Solver.solved board'' then "done" else "playing");
    board' := board''
  in
  let els =
    Array.mapi
      (fun y -> Array.mapi (fun x cell -> dom_of_cell update_board board x y))
      board
  in
  Array.iter (Dom.appendChild grid) (flat els);
  root
