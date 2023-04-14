type board
type theme

val game : theme -> board -> Js_of_ocaml.Dom_html.element Js_of_ocaml.Js.t
val demo_board : board
val theme_light : theme
val theme_dark : theme
