open Common
open Util

type style = { color : int }

type theme = {
  name : string;
  background : style;
  empty : style;
  shined : style;
  light : style;
  block : style;
}

let theme_light =
  {
    name = "Light";
    background = { color = 0xeeeeee };
    empty = { color = 0xffffff };
    shined = { color = 0xc0ff7f };
    light = { color = 0x027f60 };
    block = { color = 0x000000 };
  }

let theme_dark =
  {
    name = "Dark";
    background = { color = 0x111111 };
    empty = { color = 0x222222 };
    shined = { color = 0x027f60 };
    light = { color = 0xc0ff7f };
    block = { color = 0xeeeeee };
  }

let theme_hotdog =
  {
    name = "Hotdog";
    background = { color = 0xCC2522 };
    empty = { color = 0x995F4C };
    shined = { color = 0xC57B27 };
    light = { color = 0xE8AE02 };
    block = { color = 0x1E2C2E };
  }

let themes = [| theme_light; theme_dark; theme_hotdog |]
let local_storage = Js.Unsafe.pure_js_expr "localStorage"
let theme_key = "theme"

let save_theme theme_id =
  ignore
    (Js.Unsafe.meth_call local_storage "setItem"
       [|
         Js.Unsafe.inject (js theme_key);
         Js.Unsafe.inject (js (string_of_int theme_id));
       |])

let saved_theme =
  match
    Js.Unsafe.meth_call local_storage "getItem"
      [| Js.Unsafe.inject (js theme_key) |]
    |> Js.Opt.to_option
  with
  | None -> 0
  | Some it -> int_of_string (Js.to_string it)

let menu =
  let root = div "menu" in
  let toolbar = div "toolbar" in
  let theme_id = ref saved_theme in
  let theme_updater = div "set-theme" in
  let set_theme_elt name value =
    set_css root ("color-" ^ name) (hex_of_int value.color)
  in
  let set_theme id =
    let theme = themes.(id) in
    set_theme_elt "background" theme.background;
    set_theme_elt "empty" theme.empty;
    set_theme_elt "shined" theme.shined;
    set_theme_elt "light" theme.light;
    set_theme_elt "block" theme.block;
    theme_updater##.innerText := js theme.name
  in
  theme_updater##.onclick :=
    Html.handler (fun _ ->
        let theme_id' = (!theme_id + 1) mod Array.length themes in
        save_theme theme_id';
        set_theme theme_id';
        theme_id := theme_id';
        Js._true);
  set_theme !theme_id;
  let puzzle_creator = div "new-puzzle" in
  puzzle_creator##.innerText := js "New Puzzle";
  puzzle_creator##.onclick :=
    Html.handler (fun _ ->
        let selector =
          Js.Opt.get
            (Html.document##querySelector (js ".select"))
            (fun () -> assert false)
        in
        Dom.replaceChild root (Select.select ()) selector;
        Js._true);
  let give_up = div "give-up" in
  give_up##.innerText := js "Show Solution";
  give_up##.onclick :=
    Html.handler (fun _ ->
        let selector =
          Js.Opt.get
            (Html.document##querySelector (js ".select"))
            (fun () -> assert false)
        in
        (match Select.current_game () with
        | None -> ()
        | Some board -> begin
            match Solver.solve board with
            | None -> failwith "No solution to puzzle"
            | Some x ->
                Dom.replaceChild root (Select.set_current_game x) selector
          end);
        Js._true);
  Dom.appendChild toolbar puzzle_creator;
  Dom.appendChild toolbar give_up;
  Dom.appendChild toolbar theme_updater;
  Dom.appendChild root toolbar;
  Dom.appendChild root @@ Select.select ();
  root
