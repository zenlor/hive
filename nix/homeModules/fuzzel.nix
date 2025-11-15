{pkgs, ...}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.kitty}/bin/kitty";
        layer = "overlay";
        font = "IBM Plex Sans:weight:300";
        use-bold = "yes";
      };
    };
  };
}
