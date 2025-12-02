{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/snazzy.yaml";
    polarity = "dark";

    fonts = {
      serif = {
        package = pkgs.ibm-plex;
        name = "IBM Plex Serif";
      };
      sansSerif = {
        package = pkgs.ibm-plex;
        name = "IBM Plex Sans";
      };
      monospace = {
        package = pkgs.ibm-plex;
        name = "IBM Plex Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        desktop = 12;
        applications = 12;
        terminal = 12;
        popups = 12;
      };
    };

    targets.fontconfig.enable = true;
  };

  home.file.".icons/default".source = "${pkgs.apple-cursor}/share/icons/macOS";
}
