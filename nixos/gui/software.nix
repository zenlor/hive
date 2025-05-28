{ ... }: { pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    telegram-desktop
    firefox
    vlc
    brave
    bitwarden-cli
    bitwarden-desktop
  ];
}
