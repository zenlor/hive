{ lib, ... }: {
  imports = [
    ./_hardware.nix
    ./_networking.nix
    ./_samba.nix
    ./_services.nix
    ./_torrents.nix
    ./_users.nix
    ./_zfs-mounts.nix
    ./_plex.nix
  ];

  time.timeZone = "Europe/Amsterdam";

  security = {
    protectKernelImage = true;
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  boot.loader = {
    efi = { efiSysMountPoint = "/boot"; };
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
  };
  systemd.enableEmergencyMode = false;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
