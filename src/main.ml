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

let dom_of_board b =
  let div className =
    let div = Html.createDiv doc in
    div##.className := js className;
    div
  in
  let els =
    List.map
      (function
        | Empty -> div "empty"
        | Shined -> div "shined"
        | Filled n ->
            let el = div "filled" in
            el##.innerText := js (string_of_int n);
            el
        | Light -> div "light")
      (List.flatten b)
  in
  let grid = div "grid" in
  List.iter (Dom.appendChild grid) els;
  grid

let demo_board =
  [
    [ Shined; Shined; Light; Filled 1 ];
    [ Filled 3; Empty; Shined; Shined ];
    [ Empty; Empty; Filled 2; Light ];
    [ Empty; Empty; Empty; Shined ];
  ]



