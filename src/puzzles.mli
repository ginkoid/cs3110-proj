(** Puzzles manages the available puzzles and starting boards *)

open Common

val decode : string -> board
(** decode creates a starting board from a puzzle in
    {{:https://github.com/robx/pzprjs/blob/5d46ce86548bc71589cc9fec1ea5b7b488341023/src/variety-common/Encode.js#L13-L45}
    the pzpr 4-cell format} *)

val puzzles : board list
(** puzzles is a list of playable puzzles *)
