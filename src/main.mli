type cell =
  | Empty
  | Filled of int
  | Light
  | Shined

type board = cell array array

val dom_of_board : board -> Js_of_ocaml.Dom_html.element Js_of_ocaml.Js.t
val demo_board : board
val empty_board : int -> int -> board
