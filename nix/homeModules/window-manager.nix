{pkgs, ...}: let
  terminal = "${pkgs.kitty}/bin/kitty";
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
in {
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
}
