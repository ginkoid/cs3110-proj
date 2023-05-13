(** Common includes representations of the game board and associated utilities *)

(** cell represents a single game board cell *)
type cell = Empty | Filled of int | Light | Shined

(** board represents the game board *)
type board = cell array array

(** size returns the width and height of the board *)
val size : board -> (int * int)

(** enumerate adds an index to each element of an array *)
val enumerate : 'a array -> (int * 'a) array

(** cell_shined returns whether the cell at the given position is shined *)
val cell_shined : board -> int -> int -> bool
