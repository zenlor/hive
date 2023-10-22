{ inputs, ... }:
let
  inherit (inputs)
    nixpkgs
    ;
  inherit (nixpkgs)
    lib
    ;
in
{
  imports = [ inputs.doom-emacs.hmModule ];

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
  };

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
  ];
}
