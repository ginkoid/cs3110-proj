open Akari
open Akari.Util
open OUnit2

let test_puzzles = 
  [|
    [|
      [|
        Empty; Empty; Empty; Empty; Empty; Filled 1; Empty; Empty; Empty; Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty;
        Empty;
        Filled 4;
        Empty;
        Empty;
        Empty;
        Filled 1;
        Empty;
        Empty;
        Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Filled 1;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Filled 3;
        Empty;
        Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty;
        Empty;
        Empty;
        Empty;
        Filled 2;
        Empty;
        Empty;
        Empty;
        Filled 1;
        Empty;
      |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Filled 1; Empty; Empty; Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
    |];
  |]

let tests =
  [
    test_puzzles
    |> Array.mapi (fun i puz ->
      (Printf.sprintf "Test puzzle %d on solver" i)
        >:: (fun _ ->
          assert (
            match Solver.solve puz with
              | None -> false
              | Some soln -> Solver.solved soln
          )
        )
    )
  ]
