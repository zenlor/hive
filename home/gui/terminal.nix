{
  config.programs.alacritty = {
    enable = true;
    settings = {
      # env.TERM = "xterm-256color";
      window.decorations = "full";
      font = {
        normal = {
          family = "Iosevka Term";
          style = "Light";
        };
        bold = {
          family = "Iosevka Term";
          style = "Bold";
        };
        italic = {
          family = "Iosevka Term";
          style = "Light Italic";
        };
        bold_italic = {
          family = "Iosevka Term";
          style = "Bold Italic";
        };
        size = 14.0;
      };
      cursor.style = "Beam";

      # ayu theme
      colors = {
        primary = {
          background = "#0A0E14";
          foreground = "#B3B1AD";
        };

        # Normal colors
        normal = {
          black = "#01060E";
          red = "#EA6C73";
          green = "#91B362";
          yellow = "#F9AF4F";
          blue = "#53BDFA";
          magenta = "#FAE994";
          cyan = "#90E1C6";
          white = "#C7C7C7";
        };

        # Bright colors
        bright = {
          black = "#686868";
          red = "#F07178";
          green = "#C2D94C";
          yellow = "#FFB454";
          blue = "#59C2FF";
          magenta = "#FFEE99";
          cyan = "#95E6CB";
          white = "#FFFFFF";
        };
      };
    };
  };

  config.programs.wezterm = {
    enable = true;
    # ~/.config/wezterm/wezterm.lua
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = {}

      -- font
      config.font = wezterm.font 'Iosevka Term'
      config.font_size = 15

      -- color scheme
      config.color_scheme = 'Ayu Mirage'
      -- misc UI
      config.enable_tab_bar = true

      -- bell
      config.audible_bell = "Disabled"
      config.visual_bell = {
        fade_in_duration_ms = 75,
        fade_out_duration_ms = 75,
        target = "CursorColor",
      }

      -- tmux-like bindings
      local act = wezterm.action
      config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
      config.keys = {
        {
          mods = "CMD",
          key = "m",
          action = act.DisableDefaultAssignment,
        },
        {
          mods = "LEADER",
          key = "s",
          action = act.SplitVertical { domain = 'CurrentPaneDomain' },
        },
        {
          mods = "LEADER",
          key = "v",
          action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        -- zoom
        {
          mods = "LEADER",
          key = "m",
          action = act.TogglePaneZoomState,
        },
        -- rotate panes
        {
          mods = "LEADER",
          key = "Space",
          action = act.RotatePanes "Clockwise"
        },
        -- pane selection mode
        {
          mods = "LEADER",
          key = "'",
          action = act.PaneSelect { mode = "SwapWithActive" },
        },
        -- copy mode
        {
          mods = "LEADER",
          key = "Enter",
          action = act.ActivateCopyMode,
        },
        -- command palette
        { mods = "LEADER", key = ":", action = act.ActivateCommandPalette, },
        { mods = "CTRL", key = "p", action = act.ActivateCommandPalette, },
        -- pane movement
        { mods = "LEADER", key = "h", action = act.ActivatePaneDirection("Left"), },
        { mods = "LEADER", key = "j", action = act.ActivatePaneDirection("Down"), },
        { mods = "LEADER", key = "k", action = act.ActivatePaneDirection("Up"), },
        { mods = "LEADER", key = "l", action = act.ActivatePaneDirection("Right"), },
        -- pane selection
        -- { mods = "LEADER", key = "n", action = act.ActivateTabRelative(1), },
        -- { mods = "LEADER", key = "b", action = act.ActivateTabRelative(-1), },
        -- pane/tab creation
        { mods = "LEADER", key = "c", action = act.SpawnTab("CurrentPaneDomain"), },
        { mods = "LEADER|SHIFT", key = "k", action = act.CloseCurrentPane({confirm = false}), },
      }

      -- pane activation
      for idx = 1,9 do
        table.insert(config.keys, {
          mods = "LEADER",
          key = string.format("%s", idx),
          action = act.ActivatePaneByIndex(idx-1),
        })
      end

      return config
    '';
    colorSchemes = { };
  };
}
