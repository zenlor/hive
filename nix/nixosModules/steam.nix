{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Steam Remote Play
    dedicatedServer.openFirewall = false; # Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;

    protontricks.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    # steam with extra packages (for gamescope)
    package = pkgs.steam.override {
      extraPkgs = pkgs': with pkgs'; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib # Provides libstdc++.so.6
        libkrb5
        keyutils
        # Add other libraries as needed
      ];
    };
  };

  programs.gamescope.enable = true;

  # Steam controller
  hardware.steam-hardware.enable = true;
  services.joycond.enable = true;
  services.ratbagd.enable = true;

  environment.systemPackages = with pkgs; [
    wineWowPackages.waylandFull
    mangohud
    winetricks
    protontricks
    lutris
    gamemode
    protonup-qt
    piper # mouse configuration

    fsuae-launcher
    fsuae
  ];

  # NOTE: SteamDeck value
  boot.kernel.sysctl."vm.max_map_count" = 2147483642;
}
