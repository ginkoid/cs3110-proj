open Util
module Sat = Msat_sat
module E = Sat.Int_lit
module F = Msat_tseitin.Make(E)

(* Access a board *)
let access board x y =
  let xn, yn = size board in
  match x, y with
  | x, y when 
  (0 <= x && x < xn)
  && (0 <= y && y < yn)
    -> Some (x, y)
  | _ -> None
let cell board x y =
  access board x y
  |> Option.map (fun (x, y) -> board.(x).(y))
  |> Option.value ~default:(Filled (-1))


let span board x y dirs =
  let rec span_dir  x y acc (dx, dy) =
    match cell board x y with
    | Filled _ -> acc
    | Empty
    | Light
    | Shined -> span_dir (x+dx) (y+dy) ((x, y) :: acc) (dx, dy)
  in
  dirs
  |> List.fold_left
    (fun acc (dx, dy)-> span_dir (x+dx) (y+dy) acc (dx, dy)) [(x, y)]

let span_all board x y = span board x y [(0, 1); (0, -1); (-1, 0); (1, 0)]

let solve board = 
  (* Solver *)
  let solver = Sat.create () in
  let names = board |>
    Array.map (
      Array.map ( 
        function
          | Light
          | Shined
          | Empty -> Some (E.fresh ())
          | Filled i -> None
      )
    ) in
  (* Helper utilities *)
  let cell = cell board in
  let name x y = 
    access board x y
    |> Option.map (fun (x, y) -> names.(x).(y))
    |> Option.join
  in
  let neighbors x y =
    [(0, 1); (0, -1); (-1, 0); (1, 0)]
    |> List.map (fun (a, b) -> (x+a, y+b))
  in
  let span = span board in
  let span_all = span_all board in
  let assume x = Sat.assume solver (F.make_cnf x) () in
  let assert_n n terms = (* assert n lights *)
    let l = List.length terms in
    let negate_excpt_n terms i =
      terms
      |> List.mapi (fun j t ->
        if (0 <= (j-i) && (j-i) < n)
          || (0 <= (j+l-i) && (j+l-i) < n) then 
            t
        else F.make_not t
      )
    in
    Printf.printf "N: %d\n" n;
    match n with
      | 0 -> begin
        terms
        |> List.map F.make_not
        |> F.make_and
      end
      | n when n = l -> F.make_and terms
      | n -> terms
        (* Try negating all but n of the terms *)
        |> List.mapi (fun i _ -> negate_excpt_n terms i)
        |> List.map F.make_and
        |> F.make_or
  
  in
    (* Assert neighbors of filled blocks *)
    board |>
      Array.iteri (fun x ->
        Array.iteri (fun y -> 
          function
            | Filled i -> begin (* sum of neighbors == block number *)
              Printf.printf "Block %d at %d %d\n" i x y;
              neighbors x y
                |> List.map (fun (x, y) -> name x y)
                |> List.filter Option.is_some
                |> List.map Option.get
                |> List.map F.make_atom
                |> assert_n i
                |> assume
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
            Printf.printf "Span_all %d %d len %d\n" x y (List.length @@ span_all x y);
            (* Checks that every cell is lit by at least one light *)
              span_all x y
              |> List.map (fun (x, y) -> name x y)
              |> List.map Option.get (* should all be non-none *)
              |> List.map F.make_atom
              |> F.make_or
              |> assume
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
            Printf.printf "Starting from %d %d in %d %d dist %d\n" x y dx dy @@ List.length (span x y [(dx, dy)]);
            (* Cell was filled, now check opposite dir *)
            (* Helper function asserting a list of terms has at most 1 one *)
            let assert_max_one terms =
              [1; 0]
              |> List.map (fun x -> assert_n x terms)
              |> F.make_or
            in
            try
              span x y [(dx, dy)]
                |> List.map (fun (x, y) -> name x y)
                |> List.map Option.get (* should all be non-none *)
                |> List.map F.make_atom
                |> assert_max_one
                |> assume
            with
            | _ -> ()
          end
          | Light
          | Shined
          | Empty -> ()
        )
    )
  in
  assert_lit (1, 0);
  assert_lit (0, 1);
  let result = Sat.solve solver in
  match result with
  | Unsat _ -> None
  | Sat state -> begin
    Some (
      board |>
        Array.mapi (fun x ->
          Array.mapi (fun y ->
            function
              | Light
              | Shined
              | Empty -> 
                begin
                  if 
                    name x y
                      |> Option.get
                      |> state.Msat.eval
                  then Light
                  else Shined
                end
              | Filled i -> Filled i
          )
        )
    )
  end
    

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