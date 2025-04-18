{
  programs.alacritty = {
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
}
