{ ... }:
{ pkgs, ... }: {
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
    iosevka
    fira
    fira-code

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
    aspellDicts.en-science

    emacs-all-the-icons-fonts

    emacs29
  ];

  home.sessionPath = [ "$HOME/.config/emacs/bin" "$HOME/.config/doom/bin" ];

  xdg.configFile = {
    "doom" = {
      source = ./doom.d;
      recursive = true;
    };
  };
}
