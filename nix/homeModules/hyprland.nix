{ pkgs, ... }:
let
  terminal = "${pkgs.ghostty}/bin/ghostty";

  # tokyo-city-night
  base00 = "171D23";
  base01 = "1D252C";
  base02 = "28323A";
  base03 = "526270";
  base04 = "B7C5D3";
  base05 = "D8E2EC";
  base06 = "F6F6F8";
  base07 = "FBFBFD";
  base08 = "F7768E";
  base09 = "FF9E64";
  base0A = "B7C5D3";
  base0B = "9ECE6A";
  base0C = "89DDFF";
  base0D = "7AA2F7";
  base0E = "BB9AF7";
  base0F = "BB9AF7";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",2560x1440@120,auto,1"; # FIXME hardcoded value

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

        "col.active_border" = "rgb(8aadf4) rgb(24273A) rgb(24273A) rgb(8aadf4) 45deg";
        "col.inactive_border" = "rgb(24273A) rgb(24273A) rgb(24273A) rgb(27273A) 45deg";
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
          color = "rgba(1a1a1aee)";
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

  programs.waybar = {
    enable = true;
    settings = [
      {
        output = "DP-2";
        layer = "top";
        position = "right";
        width = 28;
        margin = "2 0 2 2";
        spacing = 2;
        modules-left = [
          "clock"
          "custom/sep"
          "tray"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          # "custom/bluetooth_devices"
          "bluetooth"
          "custom/sep"
          "temperature"
          "custom/sep"
          "pulseaudio"
          "custom/powermenu"
        ];
        "custom/sep" = {
          format = "~";
        };
        "custom/powermenu" = {
          on-click = "~/.config/wofi/scripts/wofipowermenu.py";
          format = "";
          tooltip = false;
        };
        "custom/bluetooth_devices" = {
          exec = "$HOME/.config/waybar/custom_modules/bluetooth_devices.sh";
          return-type = "json";
          format = "{}";
          justify = "center";
          rotate = 90;
          interval = 5;
          on-click = "overskride";
        };
        bluetooth = {
          format = "";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          on-click = "overskride";
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e-1";
          on-scroll-down = "hyprctl dispatch workspace e+1";
          format-icons = {
            active = "";
            urgent = "";
            default = "";
          };
        };
        clock = {
          tooltip = true;
          format = "{:%H\n%M}";
          tooltip-format = "{:%Y-%m-%d}";
        };
        tray = {
          icon-size = 18;
          show-passive-items = "true";
        };
        temperature = {
          rotate = 90;
          hwmon-path = "/sys/class/hwmon/hwmon3/temp1_input";
          critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-icons = [
            ""
            ""
            ""
          ];
        };
        pulseaudio = {
          rotate = 90;
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}%";
          format-muted = "MUTE ";
          format-icons = {
            headphones = "";
            handsfree = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
            ];
          };
          scroll-step = 3;
          on-click = "pwvucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_SOURCE@ toggle";
        };
      }
    ];

    style =
      # css
      ''
        @define-color background #${base00};
        @define-color foreground #${base0F};
        @define-color cursor #${base00};

        @define-color color0 #${base00};
        @define-color color1 #${base01};
        @define-color color2 #${base02};
        @define-color color3 #${base03};
        @define-color color4 #${base04};
        @define-color color5 #${base05};
        @define-color color6 #${base06};
        @define-color color7 #${base07};
        @define-color color8 #${base08};
        @define-color color9 #${base09};
        @define-color color10 #${base0A};
        @define-color color11 #${base0B};
        @define-color color12 #${base0C};
        @define-color color13 #${base0D};
        @define-color color14 #${base0E};
        @define-color color15 #${base0F};
        @define-color active #${base06};
        @define-color inactive #${base03};

        * {
          border: none;
          font-family: "Iosevka", "all-the-icons";
          font-size: 16px;
          font-weight: 600;
          background: none;
        }

        window#waybar {
          color: @foreground;
        }
        .modules-left,
        .modules-right,
        .modules-center {
          border-radius: 6px;
          background: @background;
          padding: 12px 0;
        }
        tooltip {
          color: @foreground;
          background-color: @background;
          text-shadow: none;
        }

        tooltip * {
          color: @foreground;
          text-shadow: none;
        }
        .modules-center {
        }

        #custom-sep {
          color: @color14;
          margin: 4px 0;
        }
        #workspaces,
        #clock,
        #custom-bluetooth_devices,
        #custom-powermenu,
        #pulseaudio,
        #tray {
        }
        #workspaces {
          border-radius: 4px;
        }
        #workspaces button {
          color: #5b6078;
          background: none;
          padding: 0;
        }
        #workspaces button:hover {
          color: #a6da95;
        }
        #workspaces button.active {
          color: #f5bde6;
        }
        #temperature {
          color: #eed49f;
        }
        #clock {
          font-weight: 600;
          color: #8bd5ca;
        }
        #custom-bluetooth_devices {
          color: #8aadf4;
        }
        #pulseaudio {
          color: #a6da95;
        }
        #pulseaudio.muted {
          color: #ed8796;
        }

        #custom-powermenu {
          margin: 12px 0 0 0;
          color: #6e738d;
        }
      '';
  };

  xdg.configFile = {
    "fuzzel/fuzzel.ini" = {
      text =
        #ini
        ''
          [main]
          font=Iosevka:size=14
          terminal=${terminal}
          prompt="$> "
          layer=overlay

          [border]
          radius=15
          width=1

          [dmenu]
          exit-immediately-if-empty=yes

          [colors]
          background=${base00}ff
          text=${base0F}ff
          selection=4b454dff
          selection-text=${base0A}ff
          border=${base06}dd
          match=${base03}ff
          selection-match=${base0B}ff
        '';
    };
  };

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
      name = "vanilla-dmz";
      package = pkgs.vanilla-dmz;
    };
  };
}
