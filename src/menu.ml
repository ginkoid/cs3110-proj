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

let themes = [|
  theme_light;
  theme_dark;
|]


let menu =
  let root = div "menu" in
  let toolbar = div "toolbar" in
  let theme_id = ref 0 in
  let theme_updater = div "set-theme" in
  let set_theme_elt name value =
    set_css root ("color-" ^ name) (hex_of_int value.color)
  in
  let set_theme id =
    let theme = themes.(id) in
    theme_id := id;
    set_theme_elt "background" theme.background;
    set_theme_elt "empty" theme.empty;
    set_theme_elt "shined" theme.shined;
    set_theme_elt "light" theme.light;
    set_theme_elt "block" theme.block;
    theme_updater##.innerText := js theme.name;
  in
  theme_updater##.onclick :=
    Html.handler (fun _ ->
      set_theme @@ (!theme_id + 1) mod (Array.length themes);
      Js._true
    );
  set_theme 0;
  let puzzle_creator = div "new-puzzle" in
  puzzle_creator##.innerText := js "New Puzzle";
  puzzle_creator##.onclick := Html.handler (fun _ ->
    let selector = Js.Opt.get (
      Html.document##querySelector (js ".select")
    ) (fun () -> assert false) in
    Dom.replaceChild root (Select.select ()) selector;
    Js._true
  );
  let give_up = div "give-up" in
  give_up##.innerText := js "Show Solution";
  give_up##.onclick := Html.handler (fun _ ->
    let selector = Js.Opt.get (
      Html.document##querySelector (js ".select")
    ) (fun () -> assert false) in
    (match Select.current_game () with
      | None -> ()
      | Some board -> begin
        match Solver.solve board with
          | None -> failwith "No solution to puzzle"
          | Some x -> Dom.replaceChild root (Select.set_current_game x) selector
      end);
    Js._true
  );
  Dom.appendChild toolbar puzzle_creator;
  Dom.appendChild toolbar give_up;
  Dom.appendChild toolbar theme_updater;
  Dom.appendChild root toolbar;
  Dom.appendChild root @@ Select.select ();
  root
