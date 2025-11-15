{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  secrets = import ../../secrets.nix;
in {
  imports = [
    inputs.self.nixosModules.common
    inputs.self.nixosModules.server

    ./disks.nix
    ./file_sharing.nix
    ./services.nix
    ./users.nix
  ];

  time.timeZone = "Europe/Amsterdam";

  boot.loader = {
    efi = {efiSysMountPoint = "/boot";};
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
  };

  systemd.enableEmergencyMode = false;
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [
    amdvlk
  ];
  # For 32 bit applications
  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = true;

  nixpkgs.hostPlatform = "x86_64-linux";

  # NAS shall consume less electricity
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  age.secrets.wireguard-key = {
    file = secrets.wireguard.nasferatu.key;
    owner = "systemd-network";
  };
  age.secrets.proton-key = {
    file = secrets.proton.nasferatu.key;
    owner = "systemd-network";
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = ["~."];
    fallbackDns = ["1.1.1.1" "1.0.0.1"];
    extraConfig = ''
      DNSOverTLS=yes
    '';
  };

  systemd.services."protonvpn-ns" = {
    description = "User ProtonVPN Network Namespace";
    before = ["network.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.iproute2}/bin/ip netns add protonvpn";
      ExecStop = "${pkgs.iproute2}/bin/ip netns del protonvpn";
      RemainAfterExit = true;
    };
    wantedBy = ["multi-user.target"];
  };

  networking = {
    hostName = "nasferatu";
    search = ["local"];
    # defaultGateway = lib.mkDefault "192.168.178.1";
    defaultGateway = {
      address = "192.168.178.1";
      interface = "enp4s0";
    };

    nameservers = lib.mkDefault ["1.1.1.1" "1.0.0.1"];

    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        53
        80
        443
        8343
        8081
        8989 # sonarr
        5357 # wsdd
        548 # netatalk

        9163 # prometheus
      ];
      allowedUDPPorts = [
        3702 # wsdd
        51820
        51821
        51822
      ];
      allowPing = true;

      trustedInterfaces = [
        "enp4s0"
        "home0"
        "proton0"
      ];

      checkReversePath = false;
    };

    hostId = "45FE4A70";
  };

  networking.useNetworkd = true;

  systemd.network = {
    enable = true;

    # lan
    networks."10-lan" = {
      matchConfig.Name = "enp4s0";
      address = ["192.168.178.2/24"];
      routes = [
        {
          Gateway = "192.168.178.1";
          GatewayOnLink = true;
          Table = 100;
          InitialCongestionWindow = 30;
          InitialAdvertisedReceiveWindow = 30;
        }
      ];
      linkConfig.RequiredForOnline = "carrier";
      routingPolicyRules = [
        {
          # User = "transmission";
          To = "0.0.0.0/0";
          Table = 100;
          Priority = 10;
        }
      ];
    };

    # home network
    netdevs."50-home" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "home0";
        MTUBytes = "1420";
      };
      wireguardConfig = {
        ListenPort = 51820;
        RouteTable = "main";
        PrivateKeyFile = config.age.secrets.wireguard-key.path;
      };
      wireguardPeers = [
        {
          PublicKey = lib.readFile secrets.wireguard.frenz.pub;
          Endpoint = secrets.wireguard.endpoint;
          AllowedIPs = secrets.wireguard.allowedIPs;
          PersistentKeepalive = 25;
        }
      ];
    };
    networks."50-home0" = {
      enable = true;
      matchConfig.Name = "home0";
      address = ["${secrets.wireguard.nasferatu.ip}/24"];
    };

    # proton network
    netdevs."60-proton" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "proton0";
        MTUBytes = "1420";
      };
      wireguardConfig = {
        ListenPort = 51821;
        RouteTable = 110;
        PrivateKeyFile = config.age.secrets.proton-key.path;
      };
      wireguardPeers = [
        {
          PublicKey = "afmlPt2O8Y+u4ykaOpMoO6q1JkbArZsaoFcpNXudXCg=";
          Endpoint = "46.29.25.3:51820";
          AllowedIPs = ["0.0.0.0/0" "::0/0"];
          PersistentKeepalive = 25;
          RouteTable = 110;
        }
      ];
    };
    networks."60-proton0" = {
      enable = true;
      matchConfig.Name = "proton0";
      address = [secrets.proton.nasferatu.ip];
      dns = ["10.2.0.1"];
      routes = [
        {
          Gateway = "10.2.0.1";
          GatewayOnLink = true;
          Table = 110;
          InitialCongestionWindow = 30;
          InitialAdvertisedReceiveWindow = 30;
        }
      ];
      routingPolicyRules = [
        {
          User = "transmission";
          Table = 110;
          Priority = 5;
        }
        {
          User = "transmission";
          Table = "main";
          To = "192.168.178.0/24";
          Priority = 1;
        }
        {
          User = "transmission";
          Table = "main";
          To = "10.69.0.0/24";
          Priority = 1;
        }
      ];
    };
  };
}
