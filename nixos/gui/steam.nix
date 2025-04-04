{ ... }:
{ pkgs, lib, ... }: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Steam Remote Play
    dedicatedServer.openFirewall = false; # Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;

    protontricks.enable = true;
  };

  programs.gamescope = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull

    steamtinkerlaunch
    winetricks
    protontricks
    lutris
  ];
}
