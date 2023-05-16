type cell =
  | Empty
  | Filled of int
  | Light
  | Shined

type board = cell array array

let size board = (Array.length board.(0), Array.length board)
let enumerate a = Array.mapi (fun i a -> (i, a)) a

let cell_shined board x y =
  let rec check x' y' (dx, dy) =
    if x' < 0 || y' < 0 || x' >= Array.length board || y' >= Array.length board
    then false
    else
      match board.(y').(x') with
      | Shined | Empty -> check (x' + dx) (y' + dy) (dx, dy)
      | Light -> true
      | Filled _ -> false
  in
  let checkdir (dx, dy) = check (x + dx) (y + dy) (dx, dy) in
  checkdir (1, 0) || checkdir (-1, 0) || checkdir (0, 1) || checkdir (0, -1)
