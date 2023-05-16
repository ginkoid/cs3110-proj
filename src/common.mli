(** Common includes representations of the game board and associated utilities *)

(** cell represents a single game board cell *)
type cell =
  | Empty
  | Filled of int
  | Light
  | Shined

type board = cell array array
(** board represents the game board *)

val size : board -> int * int
(** size returns the width and height of the board *)

val enumerate : 'a array -> (int * 'a) array
(** enumerate adds an index to each element of an array *)

val cell_shined : board -> int -> int -> bool
(** cell_shined returns whether the cell at the given position is shined *)

val hex_of_int : int -> string
(** hex_of_int converts an integer into a hex color code *)
