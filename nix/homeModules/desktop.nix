{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.theme-vertex;
      name = "Vertex";
    };
    iconTheme = {
      package = pkgs.vimix-icon-theme;
      name = "Vimix-dark";
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
