open Akari.Solver
open Akari.Common
open Akari.Puzzles
open OUnit2

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
  ]

let test_boards =
  [
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
    [|
      [| Empty; Empty; Empty |];
      [| Empty; Filled 0; Empty |];
      [| Empty; Empty; Empty |];
    |];
    [|
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty;
        Filled 0;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
        Filled 2;
        Empty;
        Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
        Filled 2;
        Empty;
        Filled 2;
        Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Filled 2;
        Empty;
      |];
      [|
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Filled 2;
        Empty;
        Empty;
        Empty;
      |];
      [|
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Filled 2;
        Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
    |];
    [|
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Filled 2; Empty; Empty; Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty; Empty; Empty; Empty; Filled 2; Empty; Empty; Empty; Empty; Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty; Empty; Filled 2; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
      |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Filled 2;
      |];
      [|
        Filled 2; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Filled 0; Empty;
      |];
      [|
        Empty; Empty; Empty; Empty; Empty; Filled 2; Empty; Empty; Empty; Empty;
      |];
    |];
    [|
      [|
        Empty; Empty; Empty; Empty; Filled 1; Empty; Empty; Empty; Empty; Empty;
      |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Filled 1; Empty;
      |];
      [|
        Empty; Filled 2; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
      |];
      [|
        Empty;
        Empty;
        Empty;
        Empty;
        Filled 2;
        Filled 2;
        Empty;
        Filled 1;
        Filled 1;
        Empty;
      |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Empty; Filled 1; Empty; Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Filled 1;
        Empty;
        Filled 3;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Filled 1;
        Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Filled 1;
      |];
    |];
    [|
      [|
        Empty;
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Filled 1;
        Empty;
        Filled 2;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty; Empty; Filled 2; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
      |];
      [|
        Empty; Filled 1; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
      |];
      [|
        Empty;
        Empty;
        Empty;
        Filled 1;
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
        Filled 1;
      |];
      [|
        Filled 0;
        Empty;
        Filled 2;
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
      |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Filled 1; Empty;
      |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Empty; Filled 1; Empty; Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Filled 1;
        Empty;
        Filled 1;
        Empty;
        Empty;
        Filled 3;
        Empty;
        Empty;
        Empty;
        Empty;
      |];
    |];
    [|
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty;
        Filled 1;
        Empty;
        Filled 1;
        Empty;
        Empty;
        Empty;
        Filled 2;
        Empty;
        Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty;
        Filled 1;
        Empty;
        Filled 1;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
      |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Filled 2; Empty;
      |];
      [|
        Empty; Filled 1; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
      |];
      [|
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Filled 2;
        Empty;
        Filled 2;
        Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty;
        Empty;
        Filled 1;
        Empty;
        Empty;
        Empty;
        Filled 2;
        Empty;
        Filled 2;
        Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
    |];
    [|
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Filled 0; Empty; Empty; Empty;
      |];
      [|
        Empty;
        Filled 0;
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Empty; Filled 0; Empty; Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Filled 0;
        Empty;
      |];
      [|
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
    |];
    [|
      [|
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
      |];
      [|
        Empty;
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
      |];
      [|
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
      |];
      [|
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
      |];
      [|
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
      |];
      [|
        Empty;
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
      |];
      [|
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
      |];
      [|
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
      |];
      [|
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
      |];
      [|
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
      |];
      [|
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Empty;
        Empty;
      |];
      [|
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
      |];
    |];
    [|
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Filled 0; Empty;
      |];
      [|
        Empty;
        Filled 0;
        Empty;
        Empty;
        Filled 2;
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
      |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Filled 2; Empty; Empty; Empty;
      |];
      [|
        Empty; Empty; Empty; Filled 0; Empty; Empty; Empty; Empty; Empty; Empty;
      |];
      [|
        Empty; Filled 0; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
      |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Filled 2; Empty;
      |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Filled 2; Empty; Empty; Empty;
      |];
      [|
        Empty; Empty; Empty; Filled 0; Empty; Empty; Empty; Empty; Empty; Empty;
      |];
      [|
        Empty;
        Empty;
        Empty;
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Filled 2;
        Empty;
      |];
      [|
        Empty; Filled 2; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
      |];
    |];
    [|
      [| Empty; Empty; Filled 1; Empty; Empty; Empty |];
      [| Empty; Empty; Empty; Empty; Empty; Empty |];
      [| Empty; Empty; Empty; Empty; Filled 1; Empty |];
      [| Empty; Empty; Empty; Empty; Empty; Empty |];
      [| Filled 2; Empty; Empty; Empty; Filled 1; Empty |];
      [| Empty; Empty; Filled 2; Empty; Empty; Empty |];
    |];
  ]

let solved_boards =
  [
    [|
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Filled 1;
        Shined;
        Shined;
        Shined;
        Light;
      |];
      [|
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Light;
        Filled 4;
        Light;
        Shined;
        Shined;
        Filled 1;
        Light;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Filled 1;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Filled 3;
        Light;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
      |];
      [|
        Light;
        Shined;
        Shined;
        Shined;
        Filled 2;
        Light;
        Shined;
        Shined;
        Filled 1;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Filled 1;
        Shined;
        Light;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
      |];
    |];
    [|
      [| Shined; Shined; Light |];
      [| Shined; Filled 0; Shined |];
      [| Light; Shined; Shined |];
    |];
    [|
      [|
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Filled 0;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Light;
        Filled 2;
        Light;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Light;
        Filled 2;
        Light;
        Filled 2;
        Light;
      |];
      [|
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
      |];
      [|
        Shined;
        Filled 0;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Filled 2;
        Shined;
      |];
      [|
        Light;
        Shined;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Filled 2;
        Shined;
        Light;
        Shined;
      |];
      [|
        Shined;
        Filled 0;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Filled 2;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
      |];
    |];
    [|
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Filled 2;
        Light;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Light;
        Filled 2;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Light;
        Filled 2;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
      |];
      [|
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Filled 2;
      |];
      [|
        Filled 2;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
      |];
      [|
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Filled 0;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Filled 2;
        Light;
        Shined;
        Shined;
        Shined;
      |];
    |];
    [|
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Filled 1;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Filled 1;
        Light;
      |];
      [|
        Light;
        Filled 2;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Light;
        Filled 2;
        Filled 2;
        Light;
        Filled 1;
        Filled 1;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Filled 1;
        Light;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Filled 1;
        Light;
        Filled 3;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Filled 1;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Filled 1;
      |];
    |];
    [|
      [|
        Light;
        Shined;
        Shined;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Filled 1;
        Light;
        Filled 2;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
      |];
      [|
        Shined;
        Light;
        Filled 2;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Filled 1;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Light;
        Filled 1;
        Shined;
        Shined;
        Shined;
        Filled 0;
        Shined;
        Filled 1;
      |];
      [|
        Filled 0;
        Shined;
        Filled 2;
        Shined;
        Shined;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Light;
      |];
      [|
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Filled 1;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Filled 1;
        Light;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Filled 1;
        Light;
        Filled 1;
        Shined;
        Light;
        Filled 3;
        Light;
        Shined;
        Shined;
        Shined;
      |];
    |];
    [|
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
      |];
      [|
        Light;
        Filled 1;
        Shined;
        Filled 1;
        Shined;
        Shined;
        Light;
        Filled 2;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Filled 1;
        Shined;
        Filled 1;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
      |];
      [|
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Filled 2;
        Shined;
      |];
      [|
        Shined;
        Filled 1;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Filled 2;
        Light;
        Filled 2;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Light;
        Filled 1;
        Shined;
        Shined;
        Light;
        Filled 2;
        Shined;
        Filled 2;
        Light;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
      |];
    |];
    [|
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Filled 0;
        Shined;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Shined;
        Filled 0;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Filled 0;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Filled 0;
        Shined;
      |];
      [|
        Light;
        Shined;
        Filled 0;
        Shined;
        Light;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Light;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
      |];
    |];
    [|
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Light;
        Shined;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Light;
      |];
      [|
        Shined;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Shined;
        Filled 0;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Light;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Filled 0;
        Shined;
        Light;
        Shined;
        Filled 0;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Filled 0;
        Shined;
        Shined;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Light;
        Shined;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Light;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
    |];
    [|
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Filled 0;
        Shined;
      |];
      [|
        Shined;
        Filled 0;
        Shined;
        Light;
        Filled 2;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Filled 2;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Light;
        Shined;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Filled 0;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Filled 2;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Shined;
        Light;
        Shined;
        Filled 2;
        Shined;
        Light;
        Shined;
      |];
      [|
        Shined;
        Shined;
        Shined;
        Filled 0;
        Shined;
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
      |];
      [|
        Shined;
        Light;
        Shined;
        Shined;
        Shined;
        Filled 0;
        Shined;
        Light;
        Filled 2;
        Light;
      |];
      [|
        Shined;
        Filled 2;
        Light;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
        Shined;
      |];
    |];
    [|
      [| Shined; Light; Filled 1; Shined; Shined; Shined |];
      [| Shined; Shined; Shined; Shined; Light; Shined |];
      [| Shined; Shined; Shined; Shined; Filled 1; Shined |];
      [| Light; Shined; Shined; Shined; Shined; Shined |];
      [| Filled 2; Shined; Light; Shined; Filled 1; Light |];
      [| Light; Shined; Filled 2; Light; Shined; Shined |];
    |];
  ]

let decode_tests =
  List.map2
    (fun puz board ->
      "puzzle " ^ puz >:: fun _ -> assert_equal (decode puz) board)
    test_puzzles test_boards

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

let suite =
  "akari"
  >::: [
         "decode" >::: decode_tests;
         "solve" >::: solve_tests;
         "solved" >::: solved_tests;
       ]

let _ = run_test_tt_main suite
