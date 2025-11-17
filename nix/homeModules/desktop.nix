{ pkgs, ... }:
{
  gtk = {
    # enable = true;
    iconTheme = {
      name = "oomox-gruvbox-dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
    font = {
      name = "Sans";
      size = 11;
    };
  };
  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme = "gtk3";
  };
}
