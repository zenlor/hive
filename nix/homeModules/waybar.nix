{ lib, pkgs, ... }:
let
  font = "IBM Plex Mono";
  position = "left";
  width = 45;

  output = [
    "DP-1"
    "eDP-0"
  ];

  barDirection = if (position == "left") || (position == "right") then "vertical" else "horizontal";

  mkGroup = modules: {
    inherit modules;
    orientation = barDirection;
  };

  mkDrawer = modules: (mkGroup modules) // { drawer.transition-duration = 250; };
  mkDrawerRtl = modules: (mkDrawer modules) // { drawer.transition-left-to-right = false; };

  mkClockModule = format: interval: tooltip: {
    inherit format interval tooltip;
    timezone = "Europe/Berlin";
    on-click = "kitty --title=clock-popup ${lib.getExe pkgs.tty-clock} -scbn";
  };

in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.default = {
      layer = "top";
      inherit position;
      inherit width;
      inherit output;

      spacing = 5;

      # managed with struts at the bottom
      exclusive = false;

      modules-left = [ "niri/window" ];
      modules-center = [
        "group/vclock"
        "group/vdate"
      ];
      modules-right = [
        "tray"
        "pulseaudio"
        "backlight"
        "battery"
        "network"
      ];

      "niri/window" = {
        seperate-outputs = true;
        icon = true;
        rotate = 90;
        rewrite = {
          "^(.*) — Mozilla Firefox$" = "$1";
          "^(.*) — LibreOffice ?(Writer|Calc|Draw|Impress|Base|Math)?$" = "$1";
        };
      };

      "group/vclock" = mkDrawer [
        "group/vclock-small"
        "clock#second"
      ];
      "group/vclock-small" = mkGroup [
        "clock#hour"
        "clock#minute"
      ];
      "group/vdate" = mkDrawer [
        "group/vdate-small"
        "clock#year"
      ];
      "group/vdate-small" = mkGroup [
        "clock#day"
        "clock#month"
      ];

      "clock#hour" = mkClockModule "{:%H}" 60 false;
      "clock#minute" = mkClockModule "{:%M}" 60 false;
      "clock#second" = mkClockModule "{:%S}" 1 false;
      "clock#day" = mkClockModule "{:%d}" 60 true;
      "clock#month" = mkClockModule "{:%m}" 60 true;
      "clock#year" = mkClockModule "{:%y}" 60 true;

      "pulseaudio" = {
        format = "{icon}";
        tooltip-format = "{volume}%";
        format-muted = "";
        format-icons = {
          headphone = "";
          default = [
            ""
            ""
            ""
          ];
        };
        on-click = "kitty --detach --title=wiremix --class=wiremix wiremix";
        scroll-step = 5.;
          };

        "backlight" = {
          format = "{icon}";
          tooltip-format = "{percent}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
          device = "amdgpu_bl1";
          scroll-step = 5.;
            };

          "battery" = {
            format = "{icon}";
            format-time = "{H}:{m}";
            tooltip-format = "{capacity}% | {time} | {power} Watts";
            states.critical = 15;
            format-charging = "";
            format-plugged = "";
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
          };

          "network" = {
            format = "{icon}";
            tooltip-format = "{ifname} | {ipaddr} | {essid}";
            format-icons = [
              "󰤯"
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
            on-click = "kitty impala";
          };

          "tray" = {
            icon-size = 21;
            spacing = 10;
            show-passive-items = true;
          };
        };

        style = ''
          * {
            font-family: ${font}, monospace;
            font-size: 1em;
          }

          window#waybar {
            background-color: transparent;
            color: @text;
          }
          window#waybar > box {
            padding: 5px;
          }

          #window,
          #vclock,
          #vdate,
          #pulseaudio,
          #backlight,
          #battery,
          #network,
          #tray {
            background-color: @surface0;
            border-radius: 5px;
            padding: 5px;
          }

          #window {
            margin-bottom: 5px;
          }

          #tray {
            padding-top: 6px;
            padding-bottom: 6px;
          }

          window#waybar.empty #window {
            background-color: transparent;
          }
        '';
      };
    }
