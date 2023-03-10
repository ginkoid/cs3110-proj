type cell = Empty
	| Lit
	| Black of int
	| Light


type board = cell list list

let rec print_board =
	let print_cell = function
		| Empty -> "🌳"
		| Lit -> "🪓"
		| Black n -> (match n with
			| 1 -> "1️⃣ "
			| 2 -> "2️⃣ "
			| 3 -> "3️⃣ "
			| 4 -> "4️⃣ "
			| _ -> "#️⃣ ")
		| Light -> "👨"
	in
	let rec print_row = function
		| [] -> ""
		| h :: t -> (print_cell h) ^ (print_row t)
	in
	function
		| [] -> ""
		| h :: t -> "|" ^ (print_row h) ^ "|\n" ^ (print_board t)

let _ = print_endline ""; print_endline @@ print_board [
	[ Empty;  Lit; Light; Black 3];
	[ Black 1;  Light; Lit; Empty];
	[ Empty; Lit; Black 2; Light];
	[Empty; Lit; Empty; Empty]
]

