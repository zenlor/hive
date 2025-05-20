{...}: {pkgs, ...}: {
  home.pointerCursor = {
    enable = true;
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    dotIcons.enable = true;
    gtk.enable = true;
    hyprcursor.enable = true;
    sway.enable = true;
  };

  home.packages = with pkgs; [
    godot
  ];
}
