{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false; # Steam Remote Play
    dedicatedServer.openFirewall = false; # Source Dedicated Server
    gamescopeSession.enable = true;
  };
}
