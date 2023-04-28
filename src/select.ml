open Util

let puzzles =
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
    [|
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty;
        Empty;
        Filled 0;
        Empty;
        Empty;
        Filled 3;
        Empty;
        Empty;
        Empty;
        Empty;
      |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Filled 3; Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty; Filled 0; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
      |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Filled 2; Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty; Filled 1; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
      |];
      [|
        Empty;
        Empty;
        Empty;
        Empty;
        Filled 1;
        Empty;
        Empty;
        Filled 2;
        Empty;
        Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
    |];
    [|
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Empty; Filled 4; Empty; Empty;
      |];
      [|
        Empty; Empty; Empty; Empty; Filled 2; Empty; Empty; Empty; Empty; Empty;
      |];
      [|
        Empty; Filled 2; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
      |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Filled 1; Empty; Empty; Empty;
      |];
      [|
        Empty; Empty; Empty; Filled 1; Empty; Empty; Empty; Empty; Empty; Empty;
      |];
      [|
        Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Filled 0; Empty;
      |];
      [|
        Empty; Empty; Empty; Empty; Empty; Filled 2; Empty; Empty; Empty; Empty;
      |];
      [|
        Empty; Empty; Filled 1; Empty; Empty; Empty; Empty; Empty; Empty; Empty;
      |];
      [| Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty; Empty |];
    |];
  |]

let select =
  let root = div "select" in
  let opts = div "opts" in
  let selects = Array.mapi (fun i puzzle ->
    let el = div "puzzle" ?innertext:(Some ("Puzzle " ^ (string_of_int (i + 1)))) in
    el##.onclick := Html.handler (fun _ ->
      Dom.replaceChild root (Main.game puzzle) opts;
      Js._true
    );
    el
  ) puzzles in
  Dom.appendChild root opts;
  Array.iter (Dom.appendChild opts) selects;
  root
