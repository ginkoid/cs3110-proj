(** Util contains utilities for interfacing with the browser DOM *)

open Js_of_ocaml

module Html = Dom_html
(** Html is module Dom_html from js_of_ocaml *)

module Js = Js
(** Js is module Js from js_of_ocaml *)

module Dom = Dom
(** Dom is module Dom from js_of_ocaml *)

val js : string -> Js.js_string Js.t
(** js converts a string into a js_of_ocaml string *)

val doc : Html.document Js.t
(** doc is the HTML document *)

val div : ?innertext:string -> ?id:string -> string -> Html.divElement Js.t
(** div creates HTML div elements *)

val hex_of_int : int -> string
(** hex_of_int converts an integer into a hex color code *)

val set_css : Html.element Js.t -> string -> string -> unit
(** set_css sets a css variable on an element *)
