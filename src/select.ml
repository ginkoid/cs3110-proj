open Common
open Util

let select, set_current_game, current_game =
  let curr_game = ref None in
  ( (fun _ ->
      curr_game := None;
      let root = div "select" in
      let opts = div "opts" in
      let selects =
        List.mapi
          (fun i puzzle ->
            let el =
              div "puzzle" ?innertext:(Some ("Puzzle " ^ string_of_int (i + 1)))
            in
            el##.onclick :=
              Html.handler (fun _ ->
                  curr_game := Some puzzle;
                  Dom.replaceChild root (Main.game puzzle) opts;
                  Js._true);
            el)
          Puzzles.puzzles
      in
      Dom.appendChild root opts;
      List.iter (Dom.appendChild opts) selects;
      root),
    (fun board ->
      let root = div "select" in
      Dom.appendChild root (Main.game board);
      root),
    fun _ -> !curr_game )
