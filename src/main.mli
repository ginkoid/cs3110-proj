type cell =
  | Empty
  | Filled of int
  | Light
  | Shined

type board = cell array array

type theme

val dom_of_board : board -> theme -> Js_of_ocaml.Dom_html.element Js_of_ocaml.Js.t
val demo_board : board
val demo_theme_light : theme
val demo_theme_dark : theme
val empty_board : int -> int -> board
