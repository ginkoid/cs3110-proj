include module type of Js_of_ocaml
module Html = Dom_html

val js : string -> Js.js_string Js.t
val doc : Html.document Js.t
val div : ?innertext:string -> ?id:string -> string -> Html.divElement Js.t
val hex_of_int : int -> string
val set_css : Html.element Js.t -> string -> string -> unit
type cell = Empty | Filled of int | Light | Shined
type board = cell array array
