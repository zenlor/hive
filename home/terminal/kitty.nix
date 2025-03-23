{
  programs.kitty = {
    enable = true;

    font = {
      name = "Iosevka";
      size = 11;
    };

    themeFile = "purpurite";

    extraConfig = ''
      enabled_layouts tall:bias=60;full_size=1;mirrored=false
    '';

    keybindings = {
      "ctrl+b>enter" = "launch --cwd=current";

      "ctrl+b>c" = "new_tab";
      "ctrl+b>z" = "close_tab";
      "ctrl+b>n" = "next_tab";
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

      "ctrl+b>h" = "neighboring_window left";
      "ctrl+b>j" = "neighboring_window bottom";
      "ctrl+b>k" = "neighboring_window top";
      "ctrl+b>l" = "neighboring_window right";

      "ctrl+b>;" = "move_window_to_top";

    };
  };
}
