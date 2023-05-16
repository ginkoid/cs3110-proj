(** Solver handles Akari game solving and solve checking *)

open Common
open Util

val solve : board -> board option
(** solve returns a solved version of the board if it exists *)

val solved : board -> bool
(** solves returns true if the board is already solved *)
