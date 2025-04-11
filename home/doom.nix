{ ... }:
{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    emacs
    emacs-all-the-icons-fonts
    pinentry-emacs
    aspell
    aspellDicts.en
    aspellDicts.en-computers
  ];

  home.sessionPath = [ "$HOME/.config/emacs/bin" "$HOME/.config/doom/bin" ];

  xdg.configFile = {
    "doom" = {
      source = ./doom.d;
      recursive = true;
    };
  };
}
