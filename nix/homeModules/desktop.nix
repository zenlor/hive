{ pkgs, ... }:
{
  gtk = {
    enable = true;
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
