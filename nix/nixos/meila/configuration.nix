{ inputs, pkgs, ... }:
{
  imports = [
    inputs.self.nixosModules.common
    inputs.self.nixosModules.workstation
    inputs.self.nixosModules.desktop
    inputs.self.nixosModules.nvidia
    inputs.self.nixosModules.steam

    inputs.self.nixosModules.gnome
    # inputs.self.nixosModules.kde
    # inputs.self.nixosModules.hyprland

    ./disks.nix
    ./home.nix
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

  networking.networkmanager.enable = true;

  # crappy razer
  hardware.openrazer = {
    enable = true;
    users = ["lor"];
    devicesOffOnScreensaver = true;
  };
  environment.systemPackages = with pkgs;[ razergenie ];
}

