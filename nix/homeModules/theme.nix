{ pkgs, ... }:
{
  catppuccin = {
    enable = true;

    accent = "teal";
    flavor = "mocha";

    bat.enable = true;
    bottom.enable = true;
    btop.enable = true;
    cursors.enable = true;
    dunst.enable = true;
    fish.enable = true;
    fuzzel.enable = true;
    fzf.enable = true;
    gitui.enable = true;
    # gtk.enable = true;
    hyprland.enable = true;
    kitty.enable = true;
    tmux.enable = true;
    zathura.enable = true;
  };

  gtk = {
    enable = true;
    font = {
      name = "Sans";
      size = 11;
    };
  };
  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "gtk3";
  };
}
