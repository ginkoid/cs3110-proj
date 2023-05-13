(** Select allows for selection of the puzzle to play *)

open Common
open Util

(** select is the puzzle selection interface *)
val select : unit -> Html.element Js.t

(** set_current_game sets the current starting board *)
val set_current_game : board -> Html.element Js.t

(** current_game retuens the game being currently played *)
val current_game : unit -> board option
