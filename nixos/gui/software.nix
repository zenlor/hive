{ ... }: { pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    firefox
    vlc
    bitwarden-cli
  ];
}
