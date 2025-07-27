{ config, lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./_hardware_configuration.nix
    ./_wireguard.nix
  ];

  hardware.enableRedistributableFirmware = true;

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
      configurationLimit = 2;
      consoleMode = "max";
    };
  };
  boot.initrd.verbose = false;
  # boot.kernelPackages = pkgs.linuxPackages-rt_latest;
  boot.plymouth.enable = true;

  systemd.enableEmergencyMode = false;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  boot.kernelParams = [
    # Quiet boot
    "quiet"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"

    # avoid some nvidia issues with wakeup/sleep
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];


  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  networking = {
    hostName = "meila";
    search = [ "local" ];
    useDHCP = lib.mkForce true;

    defaultGateway = { address = "192.168.178.1"; interface = "eno0"; };

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 53 80 443 8000 ];
      allowedUDPPorts = [ 53 ];
      allowPing = true;
    };

    hostId = "DEAFF47E";
  };
  services.resolved.enable = false;

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

  services.avahi = {
    enable = true;
    openFirewall = true;
    wideArea = true;
  };

  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
  };

  virtualisation.containerd = {
    enable = true;
  };

  virtualisation.oci-containers.backend = "podman";

  environment.systemPackages = with pkgs; [
    # dotnet-sdk_8
    mono6
    dotnetCorePackages.sdk_6_0-bin
    msbuild
    jetbrains.rider
    ollama
    yt-dlp
    vdhcoapp
  ];
}
