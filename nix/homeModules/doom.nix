{ pkgs, ... }:
{
  home.packages = with pkgs; [
    emacs
    emacs-all-the-icons-fonts

    # ssh passwords
    pinentry-emacs

    # org-mode export
    texliveMedium

    # tree sitter
    tree-sitter

    (aspellWithDicts (
      dicts: with dicts; [
        en
        en-computers
        it
      ]
    ))
  ];

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
