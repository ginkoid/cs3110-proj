open Common

let decode str =
  let parts = String.split_on_char '/' str in
  let width = int_of_string @@ List.nth parts 0 in
  let height = int_of_string @@ List.nth parts 1 in
  let pieces = List.nth parts 2 in
  let flat = Array.make (width * height) Empty in
  let inc c lo hi = c >= lo && c <= hi in
  let parse c =
    let cc = Char.code c in
    if inc c 'a' 'z' then 10 + cc - Char.code 'a'
    else if inc c '0' '9' then cc - Char.code '0'
    else failwith "invalid parse char"
  in
  ignore
  @@ String.fold_left
       (fun c ca ->
         if inc ca '0' '4' then (
           flat.(c) <- Filled (parse ca);
           c + 1)
         else if inc ca '5' '9' then (
           flat.(c) <- Filled (parse ca - 5);
           c + 2)
         else if inc ca 'a' 'e' then (
           flat.(c) <- Filled (parse ca - 10);
           c + 3)
         else if inc ca 'g' 'z' then c + parse ca - 15
         else failwith "invalid decode char")
       0 pieces;
  Array.init height (fun y -> Array.sub flat (y * width) width)

let puzzles =
  List.map decode
    [
      "10/10/kbtegbzgbjdtcgbkbq";
      "10/10/lcucuct2czkajch";
      "10/10/jbqbcp271blbz6dibxb";
    ]
