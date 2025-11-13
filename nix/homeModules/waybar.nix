{ ... }:
let
  font = "IBM Plex Mono";
in
{
  programs.waybar = {
    enable = true;

    settings = [
      {
        reload_style_on_change = true;
        toggle = true;
        position = "left";
        output = [ "DP-1" ];
        mode = "dock";
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        spacing = 0;
        modules-left = [ "clock" "cpu" ];
        modules-center = [ "niri/windows" "niri/workspaces" "privacy" ];
        modules-right = [ "group/extras" "network" "bluetooth" "pulseaudio#microphone" "group/audio" "group/brightness" "custom/powermenu" ];

        "group/extras" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 400;
            children-class = "extras";
            transition-left-to-right = false;
          };
          modules = [ "custom/menu" "tray" ];
        };

        "group/brightness" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 400;
            children-class = "brightness";
            transition-left-to-right = false;
          };
          modules = [ "backlight" "backlight/slider" ];
        };

        "group/audio" = {
          orientation = "inherit";
          drawer = {
            transition-duration= 400;
            children-class = "audio";
            transition-left-to-right = false;
          };
          modules = [ "pulseaudio" "pulseaudio/slider" ];
        };

        "custom/cachy" = {
          "format" = "";
          "tooltip" = false;
          "on-click" = "kitty";
        };

        "niri/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            default = "󰄰";
            active= "󰄯";
          };
        };

        cpu = {
          format = "{icon}";
          format-icons =[
            "<span size='14pt'>⠁</span>"
            "<span size='14pt'>⠉</span>"
            "<span size='14pt'>⠙</span>"
            "<span size='14pt'>⠛</span>"
            "<span size='14pt'>⠟</span>"
            "<span size='14pt'>⠿</span>"
          ];
          interval = 1;
          tooltip = true;
          tooltip-format = "CPU Frequency: {avg_frequency} GHz";
          on-click = "alacritty -e btm";
        };

        clock = {
          interval = 1;
          format = "{:%H\n%M}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };

        mpris = {
          format = "<span size='14pt'>󰐎</span>";
          interval = 1;
          on-click = "playerctl play-pause";
          on-click-right = "playerctl next";
          on-click-middle = "playerctl previous";
          tooltip = true;
          tooltip-format = "{title}";
        };

        "custom/menu" = {
          format = "<span size='16pt'>󰅃</span>";
          tooltip = false;
        };

        tray = {
          spacing = 16;
          reverse-direction = true;
          icon-size = 16;
          show-passive-items = false;
        };

        privacy = {
          icon-size = 14;
          transition-duration = 250;
          modules = [
            {
              type = "screenshare";
              tooltip = false;
            }
          ];
          ignore = [
            {
              type = "screenshare";
              name = "obs";
            }
          ];
        };

        network = {
          format-icons = {
            wifi = [
              "<span size='12pt'>󰤯</span>"
              "<span size='12pt'>󰤟</span>"
              "<span size='12pt'>󰤢</span>"
              "<span size='12pt'>󰤥</span>"
              "<span size='12pt'>󰤨</span>"
            ];
            ethernet ="<span size='12pt'>󰈀</span>";
            disabled = "<span size='12pt'>󰤭</span>";
            disconnected = "<span size='12pt'>󰤩</span>";
          };

          format-wifi = "{icon}";
          format-ethernet = "{icon}";
          format-disconnected = "{icon}";
          format-disabled = "{icon}";
          interval = 5;
          tooltip-format = "{essid}\t{gwaddr}";
          on-click = "rfkill toggle wifi";
          on-click-right = "nm-connection-editor";
          tooltip = true;
          max-length = 20;
        };

        bluetooth = {
          interval = 5;
          format-on = "<span size='14pt'>󰂯</span>";
          format-off = "<span size='14pt'>󰂲</span>";
          format-disabled = "<span size='14pt'>󰂲</span>";
          format-connected = "<span size='14pt'>󰂱</span>";
          tooltip = true;
          tooltip-format = "{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_address} | Battery: {device_battery_percentage}%";
          on-click = "rfkill toggle bluetooth";
          on-click-right = "blueman-manager";
        };

        "pulseaudio#microphone" = {
          format ="{format_source}";
          format-source = "<span size='14pt'>󰍬</span>";
          format-source-muted = "<span size='14pt'>󰍭</span>";
          on-click = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          tooltip = false;
        };

        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "vertical";
        };

        pulseaudio = {
          interval = 1;
          format = "{icon}";
          format-icons = [
            "<span size='14pt'>󰕿</span>"
            "<span size='14pt'>󰖀</span>"
            "<span size='14pt'>󰕾</span>"
          ];
          format-muted = "<span size='14pt'>󰝟</span>";
          on-click-right = "pavucontrol";
          on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          reverse-scrolling = true;
          tooltip = true;
          tooltip-format = "Volume: {volume}%\n{desc}";
          ignored-sinks = [
            "Easy Effects Sink"
          ];
        };

        "backlight/slider" = {
          min = 0;
          max = 100;
          orientation = "vertical";
          device ="intel_backlight";
        };

        backlight ={
          device = "intel_backlight";
          format = "{icon}";
          format-icons = [
            "󰃚"
            "󰃛"
            "󰃜"
            "󰃝"
            "󰃞"
            "󰃟"
            "󰃠"
          ];
          reverse-scrolling = true;
          smooth-scrolling-threshold = 0.2;
          tooltip = false;
        };

        battery = {
          interval = 5;
          states = {
            critical = 10;
          };
          format = "{icon}";
          format-icons = [
            "<span size='14pt'>󰁺</span>"
            "<span size='14pt'>󰁻</span>"
            "<span size='14pt'>󰁼</span>"
            "<span size='14pt'>󰁽</span>"
            "<span size='14pt'>󰁾</span>"
            "<span size='14pt'>󰁿</span>"
            "<span size='14pt'>󰂀</span>"
            "<span size='14pt'>󰂁</span>"
            "<span size='14pt'>󰂂</span>"
            "<span size='14pt'>󰁹</span>"
          ];
          format-charging = "<span size='14pt'>󰂄</span>";
          format-plugged = "<span size='14pt'>󰚥</span>";
          format-critical = "<span size='14pt'>󰂃</span>";
          tooltip = true;
          tooltip-format = "Charge: {capacity}%";
          tooltip-format-charging = "Charging: {capacity}%";
        };

        "custom/powermenu" = {
          format = "<span size='13pt'>󰐥</span>";
          on-click = "sh -c ";
          tooltip = false;
        };
      }
    ];

    style = ''
      @define-color cursor #CDD6F4;
      @define-color background #1E1E2E;
      @define-color foreground #CDD6F4;
      @define-color color0  #45475A;
      @define-color color1  #F38BA8;
      @define-color color2  #A6E3A1;
      @define-color color3  #F9E2AF;
      @define-color color4  #89B4FA;
      @define-color color5  #F5C2E7;
      @define-color color6  #94E2D5;
      @define-color color7  #BAC2DE;
      @define-color color8  #585B70;
      @define-color color9  #F38BA8;
      @define-color color10 #A6E3A1;
      @define-color color11 #F9E2AF;
      @define-color color12 #89B4FA;
      @define-color color13 #F5C2E7;
      @define-color color14 #94E2D5;
      @define-color color15 #A6ADC8;

      * {
        font-family: "${font}";
        font-size: 16px;
        border-radius: 0;
        box-shadow: none;
      }

      window#waybar {
        background: @background;
      }

      #custom-cachy:hover,
      #cpu:hover,
      #network:hover,
      #bluetooth:hover,
      #pulseaudio:hover,
      #pulseaudio.microphone:hover,
      #pulseaudio.sink-muted:hover,
      #custom-powermenu:hover {
        opacity: 0.5;
      }

      #custom-cachy,
      #cpu,
      #clock,
      #mpris,
      #custom-menu,
      #tray,
      #privacy,
      #network,
      #bluetooth,
      #pulseaudio,
      #pulseaudio.microphone,
      #backlight,
      #battery,
      #custom-powermenu {
        color: @foreground;
        padding: 6px 0;
      }

      #workspaces button {
        color: @foreground;
        padding: 0;
      }
      #workspaces button.active {
        color: @color2;
      }

      #privacy {
        margin: 4px;
        color: @color3;
      }

      #clock {
        color: @color4;
      }

      #mpris {
        color: @color3;
      }

      #network.disabled {
        color: @color1;
      }
      #network.wifi {
        color: @color2;
      }
      #network.ethernet {
        color: @color3;
      }

      #bluetooth.disabled {
        color: @color1;
      }
      #bluetooth.connected {
        color: @color4;
      }

      #pulseaudio.sink-muted:not(.microphone) {
        color: @color3;
      }
      #pulseaudio.microphone.source-muted {
        color: @color1;
      }

      #battery.plugged {
        color: @color4;
      }
      #battery.charging {
        color: @color2;
      }
      #battery.critical {
        color: @color3;
      }

      tooltip {
        background: @background;
        border: 1px solid @foreground;
      }
      tooltip * {
        color: @foreground;
        margin: 2px;
        background: @background;
      }

      #pulseaudio-slider,
      #backlight-slider {
        min-height: 80px;
      }

      #pulseaudio-slider slider,
      #backlight-slider slider {
        background: transparent;
      }

      #pulseaudio-slider trough,
      #backlight-slider trough {
        min-width: 8px;
      }

      #pulseaudio-slider highlight {
        background: @color4;
      }
      #backlight-slider highlight {
        background: @color3;
      }
    '';
  };
}
