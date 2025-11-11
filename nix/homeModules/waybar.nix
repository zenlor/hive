{ lib, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./waybar.css;
    settings = [
      {
        layer = "top";
        position = "top";
 
        modules-left = [ "niri/workspaces" ];
        modules-center = [ "niri/window" ];
        modules-right = [
          "idle_inhibitor"
          "niri/language"
          "pulseaudio"
          "disk"
          "battery"
          "custom/notification"
          "tray"
          "clock"
        ];
 
        "niri/workspaces" = {
          format = "{icon} {value}";
          format-icons = {
            active = "";
            default = "";
          };
        };
 
        "niri/window" = {
          icon = true;
        };
 
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
 
        "niri/language" = {
          format = "{short} <sup>{variant}</sup>";
        };
        "pulseaudio" = {
          format = "{icon}";
          format-bluetooth = "{icon} ";
          format-muted = "󰝟";
          format-icons = {
            headphone = "";
            default = [
              ""
              ""
            ];
          };
          scroll-step = 1;
          on-click = "${lib.getExe pkgs.pwvucontrol}";
        };
 
        clock = {
          format = "{:%H:%M}  ";
          format-alt = "{:%A; %B %d, %Y (%R)}  ";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
 
        battery = {
          format = "{icon}";
 
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          states = {
            battery-10 = 10;
            battery-20 = 20;
            battery-30 = 30;
            battery-40 = 40;
            battery-50 = 50;
            battery-60 = 60;
            battery-70 = 70;
            battery-80 = 80;
            battery-90 = 90;
            battery-100 = 100;
          };
 
          format-plugged = "󰚥";
          format-charging-battery-10 = "󰢜";
          format-charging-battery-20 = "󰂆";
          format-charging-battery-30 = "󰂇";
          format-charging-battery-40 = "󰂈";
          format-charging-battery-50 = "󰢝";
          format-charging-battery-60 = "󰂉";
          format-charging-battery-70 = "󰢞";
          format-charging-battery-80 = "󰂊";
          format-charging-battery-90 = "󰂋";
          format-charging-battery-100 = "󰂅";
          tooltip-format = "{capacity}% {timeTo}";
        };
 
        "custom/notification" = {
          format = "{icon}  {}  ";
          tooltip-format = "Left: Open Notification Center\nRight: Toggle Do not Disturb\nMiddle: Clear Notifications";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          on-click-middle = "swaync-client -C";
          escape = true;
        };
 
        tray = {
          icon-size = 21;
          spacing = 10;
        };
      }
    ];
    # style = ''
    #   #workspaces button {
    #       color: @base05;
    #   }
    # '';
  };
}
