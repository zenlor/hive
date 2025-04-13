{ ... }:
{ pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    telegram-desktop
    firefox
    wezterm
    vlc
    chromium
  ];

  programs._1password.enable = true;
  programs._1password-gui.enable = true;
}
