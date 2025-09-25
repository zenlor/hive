{ lib, ... }:
let
  font-family = "IBM Plex Mono";
in
{
  programs.ghostty = {
    enable = false; # !pkgs.stdenv.hostPlatform.isDarwin; # FIXME broken in darwin

    enableFishIntegration = true;
    installBatSyntax = true;

    settings = {
      theme = "tokyonight";
      font-size = 12;
      font-family = font-family; ## "Iosevka Fixed";
      keybind = [
        "ctrl+b>c=new_tab"

        "ctrl+b>[=previous_tab"
        "ctrl+b>]=next_tab"

        "ctrl+b>1=goto_tab:1"
        "ctrl+b>2=goto_tab:2"
        "ctrl+b>3=goto_tab:3"
        "ctrl+b>4=goto_tab:4"
        "ctrl+b>5=goto_tab:5"
        "ctrl+b>6=goto_tab:6"
        "ctrl+b>7=goto_tab:7"
        "ctrl+b>8=goto_tab:8"
      ];
    };
  };

  programs.kitty = {
    enable = true;

    font = {
      name = font-family; #"IBM Plex Mono"; #"Iosevka Term";
      size = lib.mkDefault 13;
    };

    themeFile = "tokyo_night_moon";

    settings = {
      kitty_mod = "meta+ctrl";

      bell_on_tab = "yes";
      tab_bar_edge = "bottom";
      focus_follows_mouse = "yes";
      tab_title_template = "{index}::{title}";
      enabled_layouts = "tall:bias=60;full_size=1;mirrored=false";
    };

    keybindings = {
      # remove useless crap
      "ctrl+h" = "no_op";
      "ctrl+shift+t" = "no_op";

      # actual bindings
      "ctrl+s>c" = "new_tab";
      "ctrl+s>z" = "close_tab";
      "ctrl+s>]" = "next_tab";
      "ctrl+s>n" = "next_tab";
      "ctrl+s>[" = "previous_tab";
      "ctrl+s>p" = "previous_tab";

      # Windows
      "ctrl+s>enter" = "launch --cwd=current";

      # visually move between window panes
      "ctrl+s>h" = "neighboring_window left";
      "ctrl+s>j" = "neighboring_window bottom";
      "ctrl+s>k" = "neighboring_window top";
      "ctrl+s>l" = "neighboring_window right";

      # set the main window
      "ctrl+s>;" = "move_window_to_top";

      # tab movement
      "ctrl+shift+l" = "next_tab";
      "ctrl+shift+h" = "previous_tab";

      "ctrl+s>1" = "goto_tab 1";
      "ctrl+s>2" = "goto_tab 2";
      "ctrl+s>3" = "goto_tab 3";
      "ctrl+s>4" = "goto_tab 4";
      "ctrl+s>5" = "goto_tab 5";
      "ctrl+s>6" = "goto_tab 6";
      "ctrl+s>7" = "goto_tab 7";
      "ctrl+s>8" = "goto_tab 8";
      "ctrl+s>9" = "goto_tab 9";
      "ctrl+s>0" = "goto_tab 10";
      "ctrl+s>t" = "select_tab";

      "ctrl+s>r" = "layout_action rotate";

      "ctrl+s>b" = "launch --location=hsplit --cwd=current";
      "ctrl+s>v" = "launch --location=vsplit --cwd=current";
    };
  };

  # FIXME: use a script to conditionally use kitty
  home.shellAliases.kssh = "kitty +kitten ssh";
}
