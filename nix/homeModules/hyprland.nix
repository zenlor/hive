{ pkgs, ... }:
let
  startupScript = pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    sleep 1
  '';
in
{

  wayland.windowManager.hyprland= {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      bind = [
        "$mod, enter, exec, anyrun"
        "$mod, P, exec, ghostty"
        "$mod, C, killactive"
        "$mod+ALT, M, exit"

        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"
      ];
      exec-once = ''${startupScript}/bin/start'';
    };
  };

  programs.anyrun = {
    enable = true;
    config = {
      x = {
        fraction = 0.5;
      };
      y = {
        fraction = 0.3;
      };
      width = {
        fraction = 0.7;
      };
      hideIcons = false;
      ignoreExclusiveZones = false;
      maxEntries = null;
      plugins = [
        "${pkgs.anyrun}/lib/libapplications.so"
        "${pkgs.anyrun}/lib/libsymbols.so"
      ];
    };
  };

  # home.pointerCursor = { };
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
  };
}
