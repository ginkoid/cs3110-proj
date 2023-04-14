open Js_of_ocaml
open Akari.Main
module Html = Dom_html

let js = Js.string
let doc = Html.document
let root = Js.Opt.get (doc##getElementById (js "root")) (fun () -> assert false)
let _ = Dom.appendChild root (dom_of_board demo_board demo_theme_light)
