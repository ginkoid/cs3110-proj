type difficulty =
  | Easy
  | Normal
  | Hard

let board difficulty = function
  | Easy -> Main.empty_board 5 5
  | Normal -> Main.empty_board 10 10
  | Hard -> Main.empty_board 20 20

let pick_rand_tiles board = failwith "unimplemented"
let gen_black_sq board = failwith "unimplemented"
