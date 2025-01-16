{ ... }:
{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    emacs29-pgtk
    emacs-all-the-icons-fonts

    (nerdfonts.override { fonts = [ "Iosevka" ]; })
    iosevka
    ibm-plex

    # base dependencies
    git
    (ripgrep.override { withPCRE2 = true; })
    gnutls

    # optional dependencies
    fd
    imagemagick
    zstd

    # :checkers grammar spell
    languagetool
    aspell
    aspellDicts.en
    aspellDicts.en-computers

    # org-mode exporter
    pandoc
    # pdflatex
    texlive.combined.scheme-basic

    # ssh integration
    pinentry-emacs
  ];

  home.sessionPath = [ "$HOME/.config/emacs/bin" "$HOME/.config/doom/bin" ];

  xdg.configFile = {
    "doom" = {
      source = ./doom.d;
      recursive = true;
    };
  };
}
