{ inputs
, cell
}:
let
  inherit (inputs)
    cells
    ;
in
{
  nasferatu = {
    imports = [
      cells.nixos.profiles.core
      cells.nixos.profiles.networking
      cells.nixos.profiles.openssh
      cells.nixos.profiles.cachix
      cells.nixos.profiles.users
      cells.nixos.profiles.home

      ./_hardware-configuration.nix
      ./_users.nix
      ./_zfs-mounts.nix
      ./_samba.nix
    ];

    bee = {
      system = "x86_64-linux";
      home = inputs.home-manager;
      pkgs = import inputs.nixos {
        inherit (inputs.nixpkgs) system;
        config.allowUnfree = true;
        overlays = with cells.packages.overlays; [
          common-packages
          latest-overrides
        ];
      };
    };

    security = {
      protectKernelImage = true;
      rtkit.enable = true;
      sudo.wheelNeedsPassword = false;
    };

    boot.loader = {
      efi = {
        efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
    };
    systemd.enableEmergencyMode = false;
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

    networking = {
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

          548 # netatalk
        ];
        allowedUDPPorts = [ 51820 ];
        allowPing = true;
      };

      hostId = "45FE4A70";
    };

    services.resolved = {
      enable = true;
      dnssec = "allow-downgrade";
      domains = [ "~." ];
      fallbackDns = [ "1.1.1.1" "1.0.0.1" ];
      extraConfig = ''
        DNSOverTLS=yes
      '';
    };
  };
}
