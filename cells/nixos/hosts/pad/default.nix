{ inputs
, cell }:
let
  inherit (inputs.nixpkgs)
    lib
    ;
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
    cell.profiles.development
    cell.profiles.home
    cell.profiles.shell

    cell.profiles.gui.main
    cell.profiles.gui.gnome

    ./_hardware_configuration.nix
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
  config.system.stateVersion = "23.11";

  config.time.timeZone = "Europe/Amsterdam";
  config.security = {
    protectKernelImage = true;
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  # Bootloader.

  config.boot.loader = {
    efi = {
      efiSysMountPoint = "/boot";
      canTouchEfiVariables = true;
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
    useDHCP = lib.mkDefault true;

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

  config.networking.networkmanager.enable = true;

  # Select internationalisation properties.
  config.i18n = {
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

  config.hardware.opengl.enable = true;
}
