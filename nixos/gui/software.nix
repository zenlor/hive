{ ... }:
{ pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    telegram-desktop
    firefox
    vlc
    chromium
    modrinth-app
    bitwarden-cli
    bitwarden-desktop
  ];

  programs._1password.enable = true;
  programs._1password-gui.enable = true;
}
