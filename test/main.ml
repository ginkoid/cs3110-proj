(* Test plan: All game logic code, including puzzle decoding, puzzle solving,
   puzzle correctness checking, and cell shined checking, and common shared
   code, are tested automatically by OUnit. All user interface code is tested
   manually as OUnit is unable to verify the visual look of the UI and is unable
   to run the OCaml compiled to JavaScript via js_of_ocaml.

   The modules tested by OUnit are Akari.Common, Akari.Puzzles, and
   Akari.Solver. Test cases were developed as a mix of black box and glass box
   tests. Tests of most of the game logic, including the solver, are using a
   variety of publicly available Akari puzzles. Tests of other components,
   including common shared code, are constructed by considering how the code
   interacts with its input.

   This testing approach demonstrates correctness because it subjects the core
   game logic code to a variety of real-world and complex inputs, verifying that
   the code correctly decodes, solves, and checks solve correctness on each. The
   UI code is tested via visual inspection and responds well to both a variety
   of user inputs, puzzle boards, and end-user devices. *)

open Akari.Solver
open Akari.Common
open Akari.Puzzles
open OUnit2
open Yojson.Basic.Util

let test_puzzles =
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
    "12/12/uagaiagagazlauavagaazajak";
    "11/11/gbgaazhbi2bwcw2bibzhbbgb";
    "4/4/jaiai";
    "9/9/pagajagazhasaao";
  ]

let board_of_json j =
  let cell_of_json j =
    match List.nth (to_assoc j) 0 with
    | "Empty", _ -> Empty
    | "Filled", j -> Filled (to_int j)
    | "Shined", _ -> Shined
    | "Light", _ -> Light
    | _ -> failwith "Invalid cell"
  in
  let rows = to_list j in
  let cells = List.map (fun row -> List.map cell_of_json (to_list row)) rows in
  Array.of_list (List.map Array.of_list cells)

let boards_of_file path =
  let json = Yojson.Basic.from_file path in
  let puzzles = to_list json in
  List.map board_of_json puzzles

let init_boards = boards_of_file "test/init_boards.json"
let solved_boards = boards_of_file "test/solved_boards.json"
let cell_shined_boards = boards_of_file "test/cell_shined_boards.json"

let decode_tests =
  List.map2
    (fun puz board ->
      "puzzle " ^ puz >:: fun _ -> assert_equal (decode puz) board)
    test_puzzles init_boards

let solve_tests =
  test_puzzles
  |> List.map (fun puz ->
         "puzzle " ^ puz >:: fun _ ->
         assert_bool "solve"
           (match solve (decode puz) with
           | None -> false
           | Some soln -> solved soln))

let solved_tests =
  solved_boards
  |> List.mapi (fun i board ->
         "board " ^ string_of_int i >:: fun _ ->
         assert_bool "solved" (solved board))

let unlit_board = List.nth cell_shined_boards 0
let corner_lit_board = List.nth cell_shined_boards 1
let edge_lit_board = List.nth cell_shined_boards 2

let cell_shined_tests =
  [
    ( "empty corner" >:: fun _ ->
      assert_equal (cell_shined unlit_board 0 0) false );
    ("empty edge" >:: fun _ -> assert_equal (cell_shined unlit_board 2 1) false);
    ( "corner corner" >:: fun _ ->
      assert_equal (cell_shined corner_lit_board 2 2) false );
    ( "corner edge" >:: fun _ ->
      assert_equal (cell_shined corner_lit_board 1 0) true );
    ( "edge corner" >:: fun _ ->
      assert_equal (cell_shined edge_lit_board 2 2) true );
    ( "edge edge" >:: fun _ ->
      assert_equal (cell_shined edge_lit_board 1 0) false );
  ]

let common_tests =
  [
    ("size 1" >:: fun _ -> assert_equal (size [| [| Empty |] |]) (1, 1));
    ("size 3" >:: fun _ -> assert_equal (size unlit_board) (3, 3));
    ("enumerate 0" >:: fun _ -> assert_equal (enumerate [||]) [||]);
    ( "enumerate 2" >:: fun _ ->
      assert_equal (enumerate [| 1; 2 |]) [| (0, 1); (1, 2) |] );
  ]

let suite =
  [
    "decode" >::: decode_tests;
    "solve" >::: solve_tests;
    "solved" >::: solved_tests;
    "cell_shined" >::: cell_shined_tests;
    "common" >::: common_tests;
  ]

let _ = run_test_tt_main ("akari" >::: suite)
