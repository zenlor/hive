{ lib, pkgs, ... }:
{
  programs.ghostty = {
    enable = !pkgs.stdenv.hostPlatform.isDarwin; # FIXME broken in darwin

    enableFishIntegration = true;
    installBatSyntax = true;

    settings = {
      theme = "tokyonight";
      font-size = 12;
      font-family = "Iosevka Fixed";
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
      name = "Iosevka";
      size = lib.mkDefault 11;
    };

    themeFile = "Grape";

    extraConfig = ''
      bell_on_tab yes
      tab_bar_edge bottom
      focus_follows_mouse yes
      tab_title_template {index}::{title}
      enabled_layouts tall:bias=60;full_size=1;mirrored=false
    '';

    keybindings = {
      "ctrl+b>c" = "new_tab";
      "ctrl+b>z" = "close_tab";
      "ctrl+b>]" = "next_tab";
      "ctrl+b>n" = "next_tab";
      "ctrl+b>[" = "previous_tab";
      "ctrl+b>p" = "previous_tab";

      "ctrl+b>1" = "goto_tab 1";
      "ctrl+b>2" = "goto_tab 2";
      "ctrl+b>3" = "goto_tab 3";
      "ctrl+b>4" = "goto_tab 4";
      "ctrl+b>5" = "goto_tab 5";
      "ctrl+b>6" = "goto_tab 6";
      "ctrl+b>7" = "goto_tab 7";
      "ctrl+b>8" = "goto_tab 8";
      "ctrl+b>9" = "goto_tab 9";
      "ctrl+b>0" = "goto_tab 10";
      "ctrl+b>t" = "select_tab";

      # Windows
      "ctrl+b>enter" = "launch --cwd=current";

      # visually move between window panes
      "ctrl+b>h" = "neighboring_window left";
      "ctrl+b>j" = "neighboring_window bottom";
      "ctrl+b>k" = "neighboring_window top";
      "ctrl+b>l" = "neighboring_window right";

      # set the main window
      "ctrl+b>;" = "move_window_to_top";

    };
  };

  # FIXME: use a script to conditionally use kitty
  home.shellAliases.kssh = "kitty +kitten ssh";
}
