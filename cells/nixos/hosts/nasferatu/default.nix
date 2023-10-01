{ inputs
, cell
}:
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
    cell.profiles.torrent

    ./_hardware.nix
    ./_users.nix
    ./_samba.nix
    ./_services.nix
    ./_torrents.nix
    ./_zfs-mounts.nix

    cells.home.users.nixos.lor-server
    cells.home.users.nixos.root
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
    hostName = "nasferatu";
    search = [ "local" ];
    useDHCP = false;
    interfaces.enp4s0.ipv4.addresses = [{
      address = "192.168.1.1";
      prefixLength = 24;
    }];
    defaultGateway = "192.168.1.254";
    nameservers = [ "1.1.1.1" "1.0.0.1" ];

    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        8343
        8081
        5357 # wsdd
        548  # netatalk
      ];
      allowedUDPPorts = [
        51820
        3702 # wsdd
      ];
      allowPing = true;
    };

    hostId = "45FE4A70";
  };

  config.services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1" "1.0.0.1" ];
    extraConfig = ''
      DNSOverTLS=yes
    '';
  };
}
