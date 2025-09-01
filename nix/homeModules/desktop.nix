{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };
    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
    font = {
      name = "Sans";
      size = 11;
    };
    cursorTheme = {
      name = "DMZ-Black";
      package = pkgs.vanilla-dmz;
    };
  };
}
