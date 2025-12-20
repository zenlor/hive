{ pkgs, ... }:
let
  terminal = "${pkgs.kitty}/bin/kitty";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # monitor = ",2560x1440@120,auto,1"; # FIXME hardcoded value
      monitor = [
        "DP-1,2560x1440@120,2560x0,1"
        "DP-2,2560x1440@120,0x0,1"
      ];

      exec-once = [
        "${pkgs.blueman}/bin/blueman-applet"
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.hyprnotify}/bin/hyprnotify"
      ];

      "$mod" = "SUPER";
      "$moshift" = "SUPER+SHIFT";

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind = [
        "$mod, SPACE, exec, fuzzel"
        "$mod, P, exec, ${terminal}"
        "$mod, C, killactive"
        "$mod+ALT, M, exit"

        "$mod, TAB, cyclenext, bringactivetotop"
        "ALT, TAB, workspace, previous"

        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"

        "$modshift, h, movewindow, l"
        "$modshift, j, movewindow, d"
        "$modshift, k, movewindow, u"
        "$modshift, l, movewindow, r"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$modshift, 1, movetoworkspacesilent, 1"
        "$modshift, 2, movetoworkspacesilent, 2"
        "$modshift, 3, movetoworkspacesilent, 3"

        "SUPER,Q,killactive"

        # exit session
        "SUPER,M,exit"

        "SUPER,Enter,fullscreen,1"
        "SUPERSHIFT,Enter,fullscreen,0"
        "SUPER, T, togglefloating,"

        "SUPER,C,killactive"
        "SUPERSHIFT,Q,exit"

        # "SUPER,E,exec,pcmanfm"
        # "SUPER,D,exec,rofi -show drun"

        # ",XF86AudioMute,exec,~/.config/hypr/scripts/volume mute"
        # ",XF86AudioLowerVolume,exec,~/.config/hypr/scripts/volume down"
        # ",XF86AudioRaiseVolume,exec,~/.config/hypr/scripts/volume up"
        # ",XF86AudioMicMute,exec,pactl set-source-mute @DEFAULT_SOURCE@ toggle"

        # ",XF86MonBrightnessUp,exec,~/.config/hypr/scripts/brightness up"  # increase screen brightness
        # ",XF86MonBrightnessDown,exec,~/.config/hypr/scripts/brightness down" # decrease screen brightness

        # "SUPERSHIFT,C,exec,bash ~/.config/hypr/scripts/hyprPicker.sh"
        # "SUPERSHIFT,E,exec,wlogout"

        ## Screen shot
        # "SUPERSHIFT,S,exec,grim -g \"$\(slurp)\""
        ## Emoji selector
        # "SUPERSHIFT,E,exec,rofi -modi emoji -show emoji"

        "SUPER,left,resizeactive,-40 0"
        "SUPER,right,resizeactive,40 0"

        "SUPER,up,resizeactive,0 -40"
        "SUPER,down,resizeactive,0 40"

        "SUPERSHIFT,h,movewindow,l"
        "SUPERSHIFT,l,movewindow,r"
        "SUPERSHIFT,k,movewindow,u"
        "SUPERSHIFT,j,movewindow,d"

        "SUPER,1,workspace,1"
        "SUPER,2,workspace,2"
        "SUPER,3,workspace,3"
        "SUPER,4,workspace,4"
        "SUPER,5,workspace,5"

        "SUPERSHIFT,1,movetoworkspacesilent,1"
        "SUPERSHIFT,2,movetoworkspacesilent,2"
        "SUPERSHIFT,3,movetoworkspacesilent,3"
        "SUPERSHIFT,4,movetoworkspacesilent,4"
        "SUPERSHIFT,5,movetoworkspacesilent,5"
      ];

      windowrule = [
        # Browser Picture in Picture
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "move 69.5% 4%, title:^(Picture-in-Picture)$"
        "idleinhibit fullscreen,class:([window])"
        "float, title:pwvucontrol"
      ];
      windowrulev2 = [
        "float,class:^()$,title:^(Picture in picture)$"
        "float,class:^(brave)$,title:^(Save File)$"
        "float,class:^(brave)$,title:^(Open File)$"
        "float,class:^(LibreWolf)$,title:^(Picture-in-Picture)$"
        "float,class:^(blueman-manager)$"
        "float,class:^(org.twosheds.iwgtk)$"
        "float,class:^(blueberry.py)$"
        "float,class:^(xdg-desktop-portal-gtk)$"
        "float,class:^(geeqie)$"

        "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
      ];

      general = {
        layout = "dwindle";

        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
      };

      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
          "inout, 0.79, 0.24, 0.2, 0.7"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 40, inout, once"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };

      decoration = {
        rounding = 10;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 3;
          new_optimizations = true;
          vibrancy = 0.1696;
          ignore_opacity = true;
        };
      };

      master = {
        new_on_top = true;
      };

      misc = {
        mouse_move_enables_dpms = true;
        vrr = true;
      };

      env = [
        # QT
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_STYLE_OVERRIDE,kvantum"

        # Toolkit Backend Variables
        "GDK_BACKEND,wayland,x11,*"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"

        # XDG Specifications
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
      ];
    };
  };
}
