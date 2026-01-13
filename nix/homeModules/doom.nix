{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # emacs + vterm
    ((emacsPackagesFor emacs-pgtk).emacsWithPackages (epkgs: [ epkgs.vterm ]))

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

  home.shellAliases = {
    e = "emacsclient -n -c";
  };

  xdg.configFile = {
    "doom" = {
      source = ./doom.d;
      recursive = true;
    };
  };
}
