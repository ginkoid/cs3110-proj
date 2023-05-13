type cell = Empty | Filled of int | Light | Shined
type board = cell array array
val size : board -> (int * int)
val enumerate : 'a array -> (int * 'a) array
val cell_shined : board -> int -> int -> bool
