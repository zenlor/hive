{ inputs, ... }:
let
  inherit (inputs)
    nixpkgs
    home-manager
    ;
in
{
  home.packages = with nixpkgs; [
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

    libvterm

    emacs-all-the-icons-fonts

    emacs29
  ];

  xdg.enable = true;

  home.sessionPath = [
    "$HOME/.config/emacs/bin"
    "$HOME/.config/doom/bin"
  ];

  xdg.configFile = {
    "doom" = {
      source = ./doom.d;
      recursive = true;
    };
  };
}
