{ ... }:
{ pkgs, lib, ... }: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Steam Remote Play
    dedicatedServer.openFirewall = false; # Source Dedicated Server
    gamescopeSession.enable = true;

    protontricks.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull

    winetricks
    protontricks
    lutris
  ];
}
