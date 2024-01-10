{ ... }:
{ pkgs, ... }: {
  home.packages = with pkgs; [
    corefonts
    open-fonts
    iosevka
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
