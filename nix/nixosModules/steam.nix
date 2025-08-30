{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Steam Remote Play
    dedicatedServer.openFirewall = false; # Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;

    protontricks.enable = true;
  };

  programs.gamescope.enable = true;

  # Steam controller
  hardware.steam-hardware.enable = true;
  services.joycond.enable = true;

  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull
    mangohud
    winetricks
    protontricks
    lutris
    gamemode
  ];


  # Star citizen needs more
  boot.kernel.sysctl."vm.max_map_count" = 16777216;
}
