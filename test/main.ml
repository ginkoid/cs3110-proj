open Akari.Solver
open Akari.Common
open Akari.Puzzles
open OUnit2

let test_puzzles =
  List.map decode
    [
      "10/10/kbtegbzgbjdtcgbkbq";
      "3/3/jah";
      "10/10/q5agcrag7czajchachajco";
      "10/10/lcucuct2czkajch";
      "10/10/jbqbcp271blbz6dibxb";
      "10/10/ja6cpclbobg515cgaoblbp6bdh";
      "10/10/q6bgcq6brcbr7cqbg7co";
      "10/10/vahaagazlauaagagaq";
      "12/12/vagaiagagazmazhagasagamagat";
      "10/10/naacocjakatckcjaoaccl";
      "6/6/hbqbkcgbgcg";
    ]

let solve_tests =
  test_puzzles
  |> List.mapi (fun i puz ->
         Printf.sprintf "puzzle %d" i >:: fun _ ->
         assert (
           match solve puz with
           | None -> false
           | Some soln -> solved soln))

let suite = "akari" >::: [ "solve" >::: solve_tests ]
let _ = run_test_tt_main suite
