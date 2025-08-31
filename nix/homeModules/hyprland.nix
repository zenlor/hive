{ pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",2560x1440@120,auto,1"; # FIXME hardcoded value

      "$mod" = "SUPER";
      "$moshift" = "SUPER+SHIFT";

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind = [
        "$mod, SPACE, exec, fuzzel"
        "$mod, P, exec, ghostty"
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

      exec-once = [
        "${pkgs.blueman}/bin/blueman-applet"
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.hyprnotify}/bin/hyprnotify"
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
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
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
        layer = "top";
        position = "top";
        height = 34;
        spacing = 4;

        modules-left = [
          "hyprland/window"
          "taskbar"
        ];

        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "idle_inhibitor"
          "pulseaudio"
          "bluetooth"
          "network"
          "cpu"
          "memory"
          "temperature"
          "battery"
          "clock"
        ];

        #
        # Modules configuration
        #
        "hyprland/window" = {
            format = " {initialTitle}";
            separate-outputs = true;
            on-click = "${pkgs.fuzzel}/bin/fuzzel";
        };

        taskbar = {
          format = "{icon}";
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{name}";
          format-icons = {
            urgent = "";
            active = "";
            default = "";
          };
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };

        bluetooth = {
        	format= " {status}";
        	format-connected= " {device_alias}";
        	format-connected-battery = " {device_alias} {device_battery_percentage}%";
        	# // "format-device-preference": [ "device1", "device2" ], // preference list deciding the displayed device
        	tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
        	tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
        	tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        	tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        	on-click-right = "${pkgs.overskride}/bin/overskride";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-bluetooth = "{icon} {volume}%  {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click-right = "${pkgs.pwvucontrol}/bin/pwvucontrol";
        };

        network = {
          format-wifi = "   {essid} ({signalStrength}%)";
          format-ethernet = "{ipaddr}/{cidr} ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          on-click = "sh ~/scripts/rofi-wifi-menu/rofi-wifi-menu.sh";
        };

        cpu = {
          format = "  {usage}%";
          tooltip = true;
        };

        memory = {
          format = "  {}%";
          tooltip = true;
        };

        temperature = {
          interval = 10;
          hwmon-path = "/sys/devices/platform/coretemp.0/hwmon/hwmon4/temp1_input";
          critical-threshold = 100;
          format-critical = " {temperatureC}";
          format = " {temperatureC}°C";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-full = "{icon}  {capacity}%";
          format-charging = "  {capacity}%";
          format-plugged = "  {capacity}%";
          format-alt = "{time}  {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        clock = {
          format = "{:%H:%M | %e %B} ";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
      }
    ];

    style = ''
      * {
          font-family: "Iosevka", FontAwesome, Roboto, Helvetica, Arial, sans-serif;
          font-size: 11px;
          transition: background-color .3s ease-out;
      }

      window#waybar {
          background: rgba(26, 27, 38, 0.0);
          color: #c0caf5;
          font-family: Iosevka, feather;
          transition: background-color .5s;
      }

      .modules-left,
      .modules-center,
      .modules-right
      {
          background: rgba(0, 0, 8, .7);
          margin: 2px 10px;
          padding: 0 5px;
          border-radius: 15px;
      }
      .modules-left {
          padding: 0 10px;
      }
      .modules-center {
          padding: 0 10px;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #power-profiles-daemon,
      #language,
      #mpd {
          padding: 0 10px;
          border-radius: 15px;
      }

      #clock:hover,
      #battery:hover,
      #cpu:hover,
      #memory:hover,
      #disk:hover,
      #temperature:hover,
      #backlight:hover,
      #network:hover,
      #pulseaudio:hover,
      #wireplumber:hover,
      #custom-media:hover,
      #tray:hover,
      #mode:hover,
      #idle_inhibitor:hover,
      #scratchpad:hover,
      #power-profiles-daemon:hover,
      #language:hover,
      #mpd:hover {
          background: rgba(26, 27, 38, 0.9);
      }


      #workspaces button {
        background: transparent;
        font-family:
          SpaceMono Nerd Font,
          feather;
        font-weight: 900;
        font-size: 13pt;
        color: #c0caf5;
        border:none;
        border-radius: 15px;
      }

      #workspaces button.active {
          background: #13131d; 
      }

      #workspaces button:hover {
        background: #11111b;
        color: #cdd6f4;
        box-shadow: none;
      }

      #custom-arch {
          margin-left: 5px;
          padding: 0 10px;
          font-size: 25px;
          transition: color .5s;
      }
      #custom-arch:hover {
          color: #1793d1;
      }
    '';
  };

  xdg.configFile = {
    "fuzzel/fuzzel.ini" = {
      text = ''
        [main]
        font=Iosevka:size=14
        terminal=ghostty
        prompt="$> "
        layer=overlay

        [border]
        radius=15
        width=1

        [dmenu]
        exit-immediately-if-empty=yes

        [colors]
        background=161217ff
        text=e9e0e8ff
        selection=4b454dff
        selection-text=cdc3ceff
        border=4b454ddd
        match=dfb8f6ff
        selection-match=dfb8f6ff
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
  };
}
