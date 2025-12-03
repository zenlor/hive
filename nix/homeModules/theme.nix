{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/snazzy.yaml";
    polarity = "dark";

    fonts = {
      serif = {
        package = pkgs.iosevka;
        name = "Iosevka Etoile";
      };
      sansSerif = {
        package = pkgs.iosevka;
        name = "Iosevka Aile";
      };
      monospace = {
        package = pkgs.iosevka;
        name = "Iosevka Etoile";
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

  home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
}
