{ ... }: { pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    telegram-desktop
    firefox
    vlc
    chromium
    bitwarden-cli
    bitwarden-desktop
  ];
}
