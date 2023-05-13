open Common
open Util
val select : unit -> Html.element Js.t
val set_current_game : board -> Html.element Js.t
val current_game : unit -> board option