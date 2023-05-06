open Util
(* Return a solved version of the board if it exists *)
val solve: board -> board option
(* Return true if the board is already solved *)
val solved: board -> bool