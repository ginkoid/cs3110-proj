include Js_of_ocaml
module Html = Dom_html

let js = Js.string
let doc = Html.document

let div ?(innertext = "") ?(id = "") className =
  let div = Html.createDiv doc in
  div##.innerText := js innertext;
  if className <> "" then div##.className := js className else ();
  if id <> "" then div##.id := js id else ();
  div

let set_css root name value =
  ignore
  @@ Js.Unsafe.meth_call root##.style "setProperty"
       [| Js.Unsafe.inject (js ("--" ^ name)); Js.Unsafe.inject (js value) |]
