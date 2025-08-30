{ inputs, pkgs, ... }:
{
  imports = [
    inputs.self.nixosModules.common
    inputs.self.nixosModules.workstation
    inputs.self.nixosModules.desktop
    inputs.self.nixosModules.nvidia

    # inputs.self.nixosModules.gnome
    # inputs.self.nixosModules.kde
    inputs.self.nixosModules.hyprland

    ./disks.nix
  ];

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
  };

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
  systemd.enableEmergencyMode = false;

  boot.kernelParams = [
    # Quiet boot
    "quiet"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "plymouth.theme=default"

    # avoid some nvidia issues with wakeup/sleep
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  home-manager.backupFileExtension = "backup";
  home-manager.useGlobalPkgs = true;
  home-manager.users.lor = {
    # inherit (pkgs) system;
    imports = with inputs.self.homeModules; [
      { home.stateVersion = "25.05"; }

      core
      dev
      doom
      git
      helix
      neovim
      shell
      terminal

      hyprland

      {
        programs.git.extraConfig.user.signingkey = "~/.ssh/id_ed25519.pub";
        # "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPEjb3xZe7wZ7JezbXApLdLhMeTnO2c2J8FJrpr7nWCr";
        programs.git.userName = "Lorenzo Giuliani";
        programs.git.userEmail = "lorenzo@frenzart.com";
      }
    ];
  };
}

