type cell =
  | Empty
  | Lit
  | Black of int
  | Light

type board = cell list list

let string_of_board board =
  let print_cell = function
    | Empty -> "   "
    | Lit -> " \u{25A0} "
    | Black n -> " " ^ string_of_int n ^ "\u{FE0F}\u{20E3}"
    | Light -> " \u{1F7E2} "
  in
  let print_row row = "|" ^ (List.map print_cell row |> String.concat "") ^ "|"
  in
  List.map print_row board |> String.concat "\n"

let demo_board =
  [
    [ Empty; Lit; Light; Black 3 ];
    [ Black 1; Light; Lit; Empty ];
    [ Empty; Lit; Black 2; Light ];
    [ Empty; Lit; Empty; Lit ];
  ]
