(** Solver handles Akari game solving and solve checking *)

open Common
open Util

(** solve returns a solved version of the board if it exists *)
val solve: board -> board option

(** solves returns true if the board is already solved *)
val solved: board -> bool
