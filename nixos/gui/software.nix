{ ... }:
{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    telegram-desktop
    firefox
    wezterm
    vlc
  ];

  programs._1password.enable = true;
  programs._1password-gui.enable = true;
}
