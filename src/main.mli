(** Main is the entrypoint for a single Akari game *)

open Common
open Util

val game : board -> Html.element Js.t
(** game is the entrypoint for an Akari game given a starting board *)
