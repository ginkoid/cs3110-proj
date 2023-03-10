type cell = Empty
	| Lit
	| Black of int
	| Light


type board = cell list list

let rec print_board =
	let print_cell = function
		| Empty -> " "
		| Lit -> "🤮"
		| Black n -> string_of_int n
		| Light -> "🤢"
	in
	let rec print_row = function
		| [] -> ""
		| h :: t -> (print_cell h) ^ (print_row t)
	in
	function
		| [] -> ""
		| h :: t -> "|" ^ (print_row h) ^ "|\n" ^ (print_board t)

let _ = print_endline ""; print_endline @@ print_board [
	[ Empty;  Lit];
	[ Black 1;  Light]
]

