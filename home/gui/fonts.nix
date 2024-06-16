{ ... }:
{ pkgs, ... }: {
  home.packages = with pkgs; [
    corefonts
    open-fonts
    iosevka
    iosevka-comfy-fixed
    iosevka-aile
    iosevka-etoile
    fira
    fira-go
    fira-mono
    fira-code
    ibm-plex
    input-fonts
    material-icons
    profont
    quattrocento
    unifont
    vista-fonts
    xkcd-font
  ];
}
