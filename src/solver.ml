open Util

(* Access a board *)
let access board x y =
  let xn, yn = size board in
  match x, y with
  | x, y when 
  0 <= x && x < xn
  && 0 <= y && y < yn
  -> Some (x, y)
  | _ -> None
let cell board x y =
  access board x y
  |> Option.map (fun (x, y) -> board.(x).(y))
  |> Option.value ~default:(Filled (-1))


let span board x y dirs =
  let rec span_dir acc x y (dx, dy) =
    match cell board x y with
    | Filled _ -> acc
    | Empty
    | Light
    | Shined -> span_dir ((x, y) :: acc) (x+dx) (y+dy) (dx, dy)
  in
  dirs
  |> List.fold_left (fun acc -> span_dir acc x y) []

let span_all board x y = span board x y [(0, 1); (0, -1); (-1, 0); (1, 0)]

let solve board = 
  (* Solver *)
  let open Bitwuzla.Once () in
  (* Type definitions *)
  let bv3 = Sort.bv 3 in (* 3 bit number *)
  let bv1 = Sort.bool in (* bool *)
  let names = board |>
    Array.mapi (fun x ->
      Array.mapi (fun y -> 
        function
          | Light
          | Shined
          | Empty -> Term.const bv3 @@ Printf.sprintf "%d_%d" x y
          | Filled i -> Term.Bv.of_int bv1 i
      )
    ) in
  (* Helper utilities *)
  let cell = cell board in
  let name x y = 
    access board x y
    |> Option.map (fun (x, y) -> names.(x).(y))
    |> Option.value ~default:(Term.Bv.zero bv1)
  in
  let neighbors x y =
    [(0, 1); (0, -1); (-1, 0); (1, 0)]
    |> List.map (fun (a, b) -> (x+a, y+b))
  in
  let span = span board in
  let span_all = span_all board in
  let sum = 
    List.fold_left (fun acc (x, y) ->
      name x y
      |> Term.Bv.zero_extend 2
      |> Term.Bv.add acc
    ) @@ Term.Bv.zero bv3 in
  (* Assert neighbors of filled blocks *)
  board |>
    Array.iteri (fun x ->
      Array.iteri (fun y -> 
        function
          | Filled i -> begin (* sum of neighbors == block number *)
            let lterm = neighbors x y
              |> sum in
            let rterm = name x y in
            assert' @@ Term.equal lterm rterm
          end
          | Light
          | Shined
          | Empty -> ()
      )
    );
  (* Assert each cell lit *)
  board |>
    Array.iteri (fun x ->
      Array.iteri (fun y ->
        function
          | Light
          | Shined
          | Empty -> begin
            (* Checks that every cell is lit by at least one light *)
            let terms = span_all x y
              |> List.map (fun (x, y) -> name x y)
              |> Array.of_list
              |> Term.Bl.redor
            in
            assert' terms
          end
          | Filled i -> ()
      )
    );
  (* Assert that each row/col is lit at most once *)
  let assert_lit (dx, dy) =
    board |>
      Array.iteri (fun x ->
        Array.iteri (fun y _ ->
          (* Check cell in the opposite dir of me *)
          match cell (x-dx) (y-dy) with
          | Filled _ -> begin
            (* Cell was filled, now check opposite dir *)
            (* Helper function asserting a list of terms has at most 1 one *)
            let assert_max_one terms =
              let negate_excpt_one terms i =
                terms
                |> List.mapi (fun j t ->
                  if j = i then 
                    t
                  else Term.Bl.lognot t
                )
              in
              terms
                (* Try negating all but each one of the terms *)
                |> List.mapi (fun i _ -> negate_excpt_one terms i)
                (* Negate all of the terms (all unlit) *)
                |> List.cons @@ negate_excpt_one terms (-1)
                |> List.map Array.of_list
                |> List.map Term.Bl.redand (* 1 if all but one unlit *)
                |> Array.of_list
                |> Term.Bl.redor
            in
            let terms = span x y [(dx, dy)]
              |> List.map (fun (x, y) -> name x y)
              |> assert_max_one
            in
            assert' terms
          end
          | Light
          | Shined
          | Empty -> ()
        )
    )
  in
  assert_lit (1, 0); (* Rows *)
  assert_lit (0, 1); (* Cols *)
  let result = check_sat () in
  match result with
  | Unknown
  | Unsat -> None
  | Sat -> Some (
    board |>
      Array.mapi (fun x ->
        Array.mapi (fun y ->
          function
            | Light
            | Shined
            | Empty -> if name x y
                |> get_value
                |> Term.Bl.assignment
              then Light
              else Shined
            | Filled i -> Filled i
        )
      )
  )
    

(* check if board is filled *)
  let solved board = board
    |> Array.mapi (fun x ->
      Array.mapi (fun y ->
        function 
        | Light
        | Shined
        | Empty -> begin
          span_all board x y
          |> List.map (fun (x, y) ->
            match cell board x y with
            | Light -> true
            | Shined
            | Empty -> false
            | Filled _ -> failwith "cannot span a filled cell"
          )
          |> List.fold_left (&&) true
        end
        | Filled _ -> true
      )
    )
    |> Array.map (Array.fold_left (&&) true)
    |> Array.fold_left (&&) true