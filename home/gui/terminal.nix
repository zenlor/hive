{
  config.programs.alacritty = {
    enable = true;
    settings = {
      # env.TERM = "xterm-256color";
      window.decorations = "full";
      font.size = 14.0;
      cursor.style = "Beam";

      # gruvbox theme
      colors = {
        cursor = {
          text = "0x282828";
          cursor = "0xd5c4a1";
        };
        # Default colors
        primary = {
          background = "0x282828";
          foreground = "0xd5c4a1";
        };
        # Normal colors
        normal = {
          black = "0x282828";
          red = "0xfb4934";
          green = "0xb8bb26";
          yellow = "0xfabd2f";
          blue = "0x83a598";
          magenta = "0xd3869b";
          cyan = "0x8ec07c";
          white = "0xd5c4a1";
        };
        # Bright colors
        bright = {
          black = "0x665c54";
          red = "0xfe8019";
          green = "0x3c3836";
          yellow = "0x504945";
          blue = "0xbdae93";
          magenta = "0xebdbb2";
          cyan = "0xd65d0e";
          white = "0xfbf1c7";
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
      config.font = wezterm.font 'IBM Plex Mono'
      config.font_size = 13

      -- color scheme
      config.color_scheme = 'Gruvbox dark, medium (base16)'
      -- misc UI
      config.enable_tab_bar = false

      -- bell
      config.audible_bell = "Disabled"
      config.visual_bell = {
        fade_in_duration_ms = 75,
        fade_out_duration_ms = 75,
        target = "CursorColor",
      }

      return config
    '';
    colorSchemes = { };
  };
}
