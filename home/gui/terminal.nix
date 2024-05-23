{
  config.programs.alacritty = {
    enable = true;
    settings = {
      # env.TERM = "xterm-256color";
      window.decorations = "full";
      font.size = 14.0;
      cursor.style = "Beam";

      # snazzy theme
      colors = {
        # Default colors
        primary = {
          background = "0x282a36";
          foreground = "0xeff0eb";
        };

        # Normal colors
        normal = {
          black = "0x282a36";
          red = "0xff5c57";
          green = "0x5af78e";
          yellow = "0xf3f99d";
          blue = "0x57c7ff";
          magenta = "0xff6ac1";
          cyan = "0x9aedfe";
          white = "0xf1f1f0";
        };

        # Bright colors
        bright = {
          black = "0x686868";
          red = "0xff5c57";
          green = "0x5af78e";
          yellow = "0xf3f99d";
          blue = "0x57c7ff";
          magenta = "0xff6ac1";
          cyan = "0x9aedfe";
          white = "0xf1f1f0";
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
      config.font_size = 14

      -- color scheme
      config.color_scheme = "Snazzy (base16)"
      -- misc UI
      config.enable_tab_bar = false

      -- bell
      config.audible_bell = "Disabled"
      config.visual_bell = {
        fade_in_duration_ms = 75,
        fade_out_duration_ms = 75,
        target = "CursorColor",
      }

      local function scheme_for_appearance(appearance)
        if appearance:find 'Dark' then
          return 'Tomorrow Night'
        else
          return 'Tomorrow'
        end
      end
      wezterm.on('window-config-reloaded', function(window, pane)
        local overrides = window:get_config_overrides() or {}
        local appearance = window:get_apearance()
        local scheme = scheme_for_appearance(appearance)
        if overrides.color_scheme ~= scheme then
          overrides.color_scheme = scheme
          window:set_config_overrides(overrides)
        end
      end)

      return config
    '';
    colorSchemes = { };
  };
}
