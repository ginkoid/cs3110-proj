(** Select allows for selection of the puzzle to play *)

open Common
open Util

val select : unit -> Html.element Js.t
(** select is the puzzle selection interface *)

val set_current_game : board -> Html.element Js.t
(** set_current_game sets the current starting board *)

val current_game : unit -> board option
(** current_game retuens the game being currently played *)
