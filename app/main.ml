open Js_of_ocaml
module Html = Dom_html

let js = Js.string
let doc = Html.document
let root = Js.Opt.get (doc##getElementById (js "root")) (fun () -> assert false)
let _ = Dom.appendChild root Akari.Menu.menu
