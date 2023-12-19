{ inputs
, cell }:
let
  inherit (inputs)
    cells
    ;
in
{
  imports = [
    cell.profiles.core
    cell.profiles.networking
    cell.profiles.openssh
    cell.profiles.cachix
    cell.profiles.home

    ./_hardware.nix
    ./_users.nix

    cells.home.users.nixos.lor
  ];

  config.bee = {
    system = "x86_64-linux";
    home = inputs.home-manager;
    pkgs = import inputs.nixpkgs {
      inherit (inputs.nixpkgs) system;
      config.allowUnfree = true;
      overlays = with cells.packages.overlays; [
        common-packages
        latest-overrides
      ];
    };
  };

  config.time.timeZone = "Europe/Amsterdam";
  config.security = {
    protectKernelImage = true;
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  config.boot.loader = {
    efi = {
      efiSysMountPoint = "/boot";
    };
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
  };
  config.systemd.enableEmergencyMode = false;
  config.boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  config.networking = {
    hostName = "pad";
    search = [ "local" ];
    useDHCP = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
      ];
      allowedUDPPorts = [
      ];
      allowPing = true;
    };

    hostId = "AAFE4A7E";
  };
}
