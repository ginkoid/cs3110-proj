open Lacaml.D
open Lacaml.Io


type difficulty = 
  |Easy
  |Normal
  |Hard



let board difficulty = function
  |Easy -> make_matrix 5 5 
  |Normal -> make_matrix 10 10 
  |Hard -> make_matrix 20 20 


let pick_rand_tiles board = 

let gen_black_sq board  = board |> pick_rand_tiles |> enumerate_rand_tiles
  
  

let gen_board board difficulty  = function
  |Easy -> board |> gen_num_blocks |> 
  |Normal -> board |> gen_num_blocks |>
  |Hard -> board |>  gen_num_blocks |>
  