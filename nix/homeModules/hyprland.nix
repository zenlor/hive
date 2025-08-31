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
        # height = 34;
        spacing = 8;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
          "group/info"
        ];

        "hyprland/submap" = {
          "format" = "<b>󰇘</b>";
          "max-length" = 8;
          "tooltip" = true;
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          all-outputs = true;
          format-icons = {
            "1" = "१";
            "2" = "२";
            "3" = "३";
            "4" = "४";
            "5" = "५";
            "6" = "६";
            "7" = "७";
            "8" = "८";
            "9" = "९";
            "10" = "०";
          };
        };

        "group/info" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            transition-left-to-right = false;
          };
          modules = [
            "custom/dmark"
            "group/gcpu"
            "memory"
            "disk"
          ];
        };

        "custom/dmark" = {
          format = "";
          tooltip = false;
        };
        "group/gcpu" = {
          orientation = "inherit";
          modules = [ "cpu" ];
        };
        cpu = {
          format = " 󰻠\n{usage}%";
          on-click = "foot btop";
        };
        memory = {
          on-click = "${terminal} btop";
          format = "  \n{}%";
        };
        disk = {
          on-click = "${terminal} btop";
          interval = 600;
          format = " 󰋊\n{percentage_used}%";
          path = "/";
        };

        modules-right = [
          "custom/notifications"
          "privacy"
          "custom/recorder"
          "group/brightness"
          "group/audio"
          "group/connection"
          "group/together"
          "tray"
          "group/power"
        ];
        "group/brightness" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            transition-left-to-right = false;
          };
          modules = [
            "backlight"
            "backlight/slider"
          ];
        };
        "custom/notifications" = {
          format = "<b>{}</b>";
          tooltip = false;
          exec = "${pkgs.mako}/bin/makoctl mode | grep -q 'dnd' && echo '󱏧'|| echo '󰂚' ";
          on-click = "${pkgs.mako}/bin/makoctl mode -t dnd";
          on-click-right = "${pkgs.mako}/bin/makoctl restore";
          interval = "once";
          signal = 2;
        };
        backlight = {
          device = "intel_backlight";
          format = "{icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
          on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl s 5%-";
          on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl s +5%";
          tooltip = true;
          tooltip-format = "{percent}% ";
          smooth-scrolling-threshold = 1;
        };
        "backlight/slider" = {
          min = 5;
          max = 100;
          orientation = "vertical";
          device = "intel_backlight";
        };

        "group/audio" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            transition-left-to-right = false;
          };
          "modules" = [
            "wireplumber"
            "pulseaudio#mic"
            "pulseaudio/slider"
          ];
        };
        wireplumber = {
          format = "{icon}";
          format-bluetooth = "{icon}";
          tooltip-format = "{volume}% {icon} | {desc}";
          format-muted = "󰖁";
          format-icons = {
            headphones = "󰋌";
            handsfree = "󰋌";
            headset = "󰋌";
            phone = "";
            portable = "";
            car = " ";
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-middle = "${pkgs.pwvucontrol}/bin/pwvucontrol";
          on-scroll-up = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+";
          on-scroll-down = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%-";
          smooth-scrolling-threshold = 1;
        };
        "pulseaudio#mic" = {
          format = "{format_source}";
          format-source = "";
          format-source-muted = "󰍭";
          tooltip-format = "{volume}% {format_source} ";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          on-scroll-up = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SOURCE@ 1%+";
          on-scroll-down = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SOURCE@ 1%-";
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "vertical";
        };
        "group/together" = {
          orientation = "inherit";
          modules = [
            "group/utils"
            "clock"
          ];
        };
        "group/utils" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            transition-left-to-right = true;
          };
          modules = [
            "custom/mark"
            "custom/weather"
            "idle_inhibitor"
            "custom/hyprkill"
          ];
        };

        tray = {
          icon-size = 18;
          spacing = 10;
        };
        "custom/hyprkill" = {
          format = "{}";
          interval = "once";
          exec = ''
            echo "󰅙
            Kill clients using hyrpctl kill"'';
          on-click = "sleep 1 && hyprctl kill";
        };
        "custom/weather" = {
          format = "{}";
          tooltip = true;
          interval = 3600;
          exec = ''
            ${pkgs.wttrbar}/bin/wttrbar --custom-indicator '{ICON}
            {temp_C}' --location amsterdam
          '';
          return-type = "json";
        };
        "custom/mark" = {
          format = "";
          tooltip = false;
        };
        clock = {
          format = ''
            {:%H
            %M}'';
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              today = "<span color='#${base0A}'><b><u>{}</u></b></span>";
            };
          };
        };
        idle_inhibitor = {
          format = "{icon}";
          tooltip-format-activated = "Idle Inhibitor is active";
          tooltip-format-deactivated = "Idle Inhibitor is not active";
          format-icons = {
            activated = "󰔡";
            deactivated = "󰔢";
          };
        };

        "group/connection" = {
          orientation = "inherit";
          modules = [
            "custom/vpn"
            "group/network"
            "group/bluetooth"
          ];
        };
        "group/network" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            transition-left-to-right = true;
          };
          modules = [
            "network"
            "network#speed"
          ];
        };

        network = {
          format = "{icon}";
          format-icons = {
            wifi = [ "󰤨" ];
            ethernet = [ "󰈀" ];
            disconnected = [ "󰖪" ];
          };
          format-wifi = "󰤨";
          format-ethernet = "󰈀";
          format-disconnected = "󰖪";
          format-linked = "󰈁";
          tooltip = false;
          # on-click = "killall rofi || uwsm app -- ${lib.getExe' pkgs.utils-menus "network"}";
        };
        "network#speed" = {
          format = " {bandwidthDownBits} ";
          rotate = 90;
          interval = 5;
          tooltip-format = "{ipaddr}";
          tooltip-format-wifi = ''
            {essid} ({signalStrength}%) 
            {ipaddr} | {frequency} MHz{icon} '';
          tooltip-format-ethernet = ''
            {ifname} 󰈀
            {ipaddr} | {frequency} MHz{icon} '';
          tooltip-format-disconnected = "Not Connected to any type of Network";
          tooltip = true;
          # on-click = "killall rofi || uwsm app -- ${lib.getExe' pkgs.utils-menus "network"}";
        };
        "custom/vpn" = {
          signal = 5;
          return-type = "json";
          format = "{} ";
          interval = 5;
          # exec = vpn;
        };
        bluetooth = {
          format-on = "";
          format-off = "󰂲";
          format-disabled = "";
          format-connected = "<b></b>";
          tooltip-format = ''
            {controller_alias}	{controller_address}

            {num_connections} connected'';
          tooltip-format-connected = ''
            {controller_alias}	{controller_address}

            {num_connections} connected

            {device_enumerate}'';
          tooltip-format-enumerate-connected = "{device_alias}	{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}	{device_address}	{device_battery_percentage}%";
          # on-click = "killall rofi || uwsm app -- ${lib.getExe' pkgs.utils-menus "bluetooth"}";
        };
        "group/bluetooth" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            transition-left-to-right = true;
          };
          modules = [
            "bluetooth"
            "bluetooth#status"
          ];
        };
        "bluetooth#status" = {
          format-on = "";
          format-off = "";
          format-disabled = "";
          format-connected = "<b>{num_connections}</b>";
          format-connected-battery = "<small><b>{device_battery_percentage}%</b></small>";
          tooltip-format = ''
            {controller_alias}	{controller_address}

            {num_connections} connected'';
          tooltip-format-connected = ''
            {controller_alias}	{controller_address}

            {num_connections} connected

            {device_enumerate}'';
          tooltip-format-enumerate-connected = "{device_alias}	{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}	{device_address}	{device_battery_percentage}%";
          # on-click = "killall rofi || uwsm app -- ${lib.getExe' pkgs.utils-menus "bluetooth"}";
        };
        privacy = {
          orientation = "vertical";
          icon-spacing = 4;
          icon-size = 14;
          transition-duration = 250;
          modules = [
            {
              "type" = "screenshare";
              "tooltip" = true;
              "tooltip-icon-size" = 24;
            }
          ];
        };
        "custom/recorder" = {
          format = "{}";
          interval = "once";
          exec = "echo ''";
          tooltip = "false";
          exec-if = "pgrep -x wl-screenrec";
          on-click = "${pkgs.wl-screenrec}/bin/wl-screenrec";
          signal = 4;
        };
        "group/power" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            transition-left-to-right = false;
          };
          modules = [ "battery" ];
        };
        battery = {
          rotate = 270;
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-charging = "<b>{icon} </b>";
          format-full = "<span color='#82A55F'><b>{icon}</b></span>";
          format-icons = [
            "󰁻"
            "󰁻"
            "󰁼"
            "󰁼"
            "󰁾"
            "󰁾"
            "󰂀"
            "󰂀"
            "󰂂"
            "󰂂"
            "󰁹"
          ];
          tooltip-format = "{timeTo} {capacity} % | {power} W";
        };
      }
    ];

    style =
      let
        radius = "10px";
        radius-small = "5px";
        alpha = "0.3";
      in
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
          min-width: 8px;
          min-height: 0px;
        }

        window#waybar {
          transition-property: background-color;
          transition-duration: 0.5s;
          border-radius: ${radius};
          border: 2px solid @active;
          background: alpha(@background, ${alpha});
          color: lighter(@active);
        }

        menu,
        tooltip {
          border-radius: ${radius};
          padding: 2px;
          border: 1px solid lighter(@active);
          background: alpha(@background, 0.6);

          color: lighter(@active);
        }

        menu label,
        tooltip label {
          font-size: 14px;
          color: lighter(@active);
        }

        #submap,
        #tray>.needs-attention {
          animation-name: blink-active;
          animation-duration: 1s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        .modules-right {
          margin: 0px 6px 6px 6px;
          border-radius: ${radius-small};
          background: alpha(@background, 0.4);
          color: lighter(@active);
          padding: 2px 2px 4px 2px;
        }

        .modules-left {
          transition-property: background-color;
          transition-duration: 0.5s;
          margin: 6px 6px 6px 6px;
          border-radius: ${radius-small};
          background: alpha(@background, 0.4);
          color: lighter(@active);
        }

        #gcpu,
        #custom-github,
        #custom-notifications,
        #memory,
        #disk,
        #together,
        #submap,
        #custom-weather,
        #custom-recorder,
        #connection,
        #cnoti,
        #power,
        #custom-updates,
        #tray,
        #privacy {
          margin: 3px 0px;
          border-radius: ${radius-small};
          background: alpha(darker(@active), 0.3);
        }

        #audio {
          margin-top: 3px;
        }

        #brightness,
        #audio {
          border-radius: ${radius-small};
          background: alpha(darker(@active), 0.3);
        }

        #custom-notifications {
          padding-right: 4px;
        }

        #custom-hotspot,
        #custom-github,
        #custom-notifications {
          font-size: 14px;
        }

        #custom-hotspot {
          padding-right: 2px;
        }

        #custom-vpn,
        #custom-hotspot {
          background: alpha(darker(@active), 0.3);
        }

        #privacy-item {
          padding: 6px 0px 6px 6px;
        }

        #gcpu {
          padding: 8px 0px 8px 0px;
        }

        #custom-cpu-icon {
          font-size: 25px;
        }

        #custom-cputemp,
        #disk,
        #memory,
        #cpu {
          font-size: 14px;
          font-weight: bold;
        }

        #custom-github {
          padding-top: 2px;
          padding-right: 4px;
        }

        #custom-dmark {
          color: alpha(@foreground, 0.3);
        }

        #submap {
          margin-bottom: 0px;
        }

        #workspaces {
          margin: 0px 2px;
          padding: 4px 0px 0px 0px;
          border-radius: ${radius};
        }

        #workspaces button {
          transition-property: background-color;
          transition-duration: 0.5s;
          color: @foreground;
          background: transparent;
          border-radius: ${radius-small};
          color: alpha(@foreground, 0.3);
        }

        #workspaces button.urgent {
          font-weight: bold;
          color: @foreground;
        }

        #workspaces button.active {
          padding: 4px 2px;
          background: alpha(@active, 0.4);
          color: lighter(@active);
          border-radius: ${radius-small};
        }

        #network.wifi {
          padding-right: 4px;
        }

        #submap {
          min-width: 0px;
          margin: 4px 6px 4px 6px;
        }

        #custom-weather,
        #tray {
          padding: 4px 0px 4px 0px;
        }

        #bluetooth {
          padding-top: 2px;
        }

        #battery {
          border-radius: ${radius};
          padding: 4px 0px;
          margin: 4px 2px 4px 2px;
        }

        #battery.discharging.warning {
          animation-name: blink-yellow;
          animation-duration: 1s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        #battery.discharging.critical {
          animation-name: blink-red;
          animation-duration: 1s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        #clock {
          font-weight: bold;
          padding: 4px 2px 2px 2px;
        }

        #pulseaudio.mic {
          border-radius: ${radius-small};
          color: @background;
          background: alpha(darker(@foreground), 0.6);
        }

        #backlight-slider slider,
        #pulseaudio-slider slider {
          background-color: transparent;
          box-shadow: none;
        }

        #backlight-slider trough,
        #pulseaudio-slider trough {
          margin-top: 4px;
          min-width: 6px;
          min-height: 60px;
          border-radius: ${radius};
          background-color: alpha(@background, 0.6);
        }

        #backlight-slider highlight,
        #pulseaudio-slider highlight {
          border-radius: ${radius};
          background-color: lighter(@active);
        }

        #bluetooth.discoverable,
        #bluetooth.discovering,
        #bluetooth.pairable {
          border-radius: ${radius};
          animation-name: blink-active;
          animation-duration: 1s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        @keyframes blink-active {
          to {
            background-color: @active;
            color: @foreground;
          }
        }

        @keyframes blink-red {
          to {
            background-color: #c64d4f;
            color: @foreground;
          }
        }

        @keyframes blink-yellow {
          to {
            background-color: #cf9022;
            color: @foreground;
          }
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
