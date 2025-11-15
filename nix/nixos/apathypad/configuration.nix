{ inputs
, config
, lib
, ...
}:
let
  secrets = import ../../secrets.nix;
in
{
  imports = [
    inputs.agenix.nixosModules.default

    inputs.self.nixosModules.common
    inputs.self.nixosModules.desktop

    ./hardware.nix
  ];

  time.timeZone = "Europe/Amsterdam";
  security = {
    protectKernelImage = true;
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  boot.loader = {
    efi = {
      efiSysMountPoint = "/boot";
      canTouchEfiVariables = true;
    };
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
  };
  systemd.enableEmergencyMode = false;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  networking = {
    hostName = "pad";
    search = [ "local" ];
    useDHCP = lib.mkForce false;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
        8000
      ];
      allowPing = true;
    };

    hostId = "AAFE4A7E";
  };
  services.resolved.enable = lib.mkForce false;

  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "it_IT.UTF-8";
      LC_IDENTIFICATION = "it_IT.UTF-8";
      LC_MEASUREMENT = "it_IT.UTF-8";
      LC_MONETARY = "it_IT.UTF-8";
      LC_NAME = "it_IT.UTF-8";
      LC_NUMERIC = "it_IT.UTF-8";
      LC_PAPER = "it_IT.UTF-8";
      LC_TELEPHONE = "it_IT.UTF-8";
      LC_TIME = "it_IT.UTF-8";
    };
  };

  services.flatpak.enable = true;

  services.avahi = {
    enable = true;
    openFirewall = true;
    wideArea = true;
  };

  age.secrets.wireguard-key.file = secrets.wireguard.pad.key;

  networking.firewall.allowedUDPPorts = [ 51820 ];

  networking.wireguard.interfaces.wg0 = {
    ips = [ "${secrets.wireguard.pad.ip}/24" ];
    listenPort = 51820;
    privateKeyFile = config.age.secrets.wireguard-key.path;

    peers = [
      {
        publicKey = lib.readFile secrets.wireguard.frenz.pub;
        allowedIPs = secrets.wireguard.allowedIPs;
        endpoint = secrets.wireguard.endpoint;
        persistentKeepalive = 25;
      }
    ];
  };
}
