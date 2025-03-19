{ config, lib, ... }: {

  imports = [
    ./_hardware.nix
    ./_samba.nix
    ./_services.nix
    ./_torrents.nix
    ./_users.nix
    ./_zfs-mounts.nix
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

  networking = {
    hostName = "nasferatu";
    search = [ "local" ];
    useDHCP = false;
    interfaces.enp4s0.ipv4.addresses = [{
      address = "192.168.178.2";
      prefixLength = 24;
    }];
    defaultGateway = "192.168.178.1";
    nameservers = [ "1.1.1.1" "1.0.0.1" ];

    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        8343
        8081
        8989 # sonarr
        5357 # wsdd
        548 # netatalk
      ];
      allowedUDPPorts = [
        51820
        3702 # wsdd
      ];
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
}
