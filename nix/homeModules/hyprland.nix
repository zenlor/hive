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
        "${pkgs.ashell}/bin/ashell"
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
        # col.active_border = "0xff5e81ac";
        # col.inactive_border = "0x66333333";

        # apply_sens_to_raw=0 # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
      };

      decoration = {
        rounding = 8;
        blur = {
          enabled = 1;
          size = 6;
          passes = 2;
          new_optimizations = true;

          # Your blur "amount" is size * passes, but high size (over around 5-ish)
          # will produce artifacts.
          # if you want heavy blur, you need to up the passes.
          # the more passes, the more you can up the size without noticing artifacts.
        };
        shadow = {
          enabled = true;
          range = 2;
          color = "0x000000f0";
          color_inactive = "0x50000000";
        };
      };

      blurls = [
        "ashell"
        "lockscreen"
      ];

      animations = {
        enabled = 1;
        # bezier=overshot,0.05,0.9,0.1,1.1
        bezier = "overshot,0.13,0.99,0.29,1.1";
        animation = [
          "windows,1,4,overshot,popin"
          "fade,1,10,default"
          "workspaces,1,6,overshot,slide"
          "border,1,10,default"
        ];
      };

      dwindle = {
        pseudotile = 1; # enable pseudotiling on dwindle
        force_split = 0;
      };

      master = {
        new_on_top = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        vfr = false;
      };

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
        "${pkgs.anyrun}/lib/libshell.so"
      ];
    };
  };

  programs.hyprpanel = {
    # Configure and theme almost all options from the GUI.
    # See 'https://hyprpanel.com/configuration/settings.html'.
    # Default: <same as gui>
    settings = {

      # Configure bar layouts for monitors.
      # See 'https://hyprpanel.com/configuration/panel.html'.
      # Default: null
      layout = {
        bar.layouts = {
          "0" = {
            left = [ "dashboard" "workspaces" ];
            middle = [ "media" ];
            right = [ "volume" "systray" "notifications" ];
          };
        };
      };

      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      theme.bar.transparent = true;

      theme.font = {
        name = "CaskaydiaCove NF";
        size = "16px";
      };
    };
  };

  xdg.configFile = {
    "ashell/config.toml" = {
      text = ''
        log_level = "warn"
        app_launcher_cmd = "${pkgs.anyrun}/bin/anyrun"

        [system]
        indicators = [ "Temperature" "Cpu" "Memory" ]
        [system.cpu]
        warn_threshold = 65
        alert_threshold = 85
        [system.memory]
        warn_threshold = 50
        alert_threshold = 85
        [system.temperature]
        warn_threshold = 65
        alert_threshold = 85

        [appearance]
        opacity = 0.7
        style = "Islands"
        font_name = "Iosevka - Medium"

        [appearance.menu]
        opacity = 0.7
        backdrop = 0.3

        [settings]
        audio_sinks_more_cmd = "pwvucontrol -t 3"
        audio_sources_more_cmd = "pwvucontrol -t 3"
        bluetooth_more_cmd = "overskride"
        vpn_more_cmd = "nm-connection-editor"
      '';
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
