{ ... }:
{ pkgs, ... }: {
  home.packages = with pkgs; [
    emacs-pgtk
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
