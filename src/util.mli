(** Util contains utilities for interfacing with the browser DOM *)

open Js_of_ocaml

(** Html is module Dom_html from js_of_ocaml *)
module Html = Dom_html

(** Js is module Js from js_of_ocaml *)
module Js = Js

(** Dom is module Dom from js_of_ocaml *)
module Dom = Dom

(** js converts a string into a js_of_ocaml string *)
val js : string -> Js.js_string Js.t

(** doc is the HTML document *)
val doc : Html.document Js.t

(** div creates HTML div elements *)
val div : ?innertext:string -> ?id:string -> string -> Html.divElement Js.t

(** hex_of_int converts an integer into a hex color code *)
val hex_of_int : int -> string

(** set_css sets a css variable on an element *)
val set_css : Html.element Js.t -> string -> string -> unit
