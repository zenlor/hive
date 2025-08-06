{ ... }:
{ pkgs, ... }: {
  home.packages =
    # let
    #   emacs-custom-options = pkgs.emacs-pgtk.override {
    #     withNativeCompilation = false; # FIXME currently broken in MacOSX
    #     withSQLite3 = true;
    #     withTreeSitter = true;
    #   };
    #   emacs-custom = (pkgs.emacsPackagesFor emacs-custom-options).emacsWithPackages (epkgs: with epkgs; [
    #     vterm
    #     multi-vterm
    #     treesit-grammars.with-all-grammars
    #   ]);
    # in
    with pkgs; [
      emacs
      emacs-all-the-icons-fonts
      pinentry-emacs

      (aspellWithDicts (dicts: with dicts; [
        en
        en-computers
        # en-science # this is marked non-free
      ]))

      # export things
      texliveMedium
    ];

  home.sessionPath = [ "$HOME/.config/emacs/bin" "$HOME/.config/doom/bin" ];

  xdg.configFile = {
    "doom" = {
      source = ./doom.d;
      recursive = true;
    };
  };
}
