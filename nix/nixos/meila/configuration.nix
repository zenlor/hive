{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.common.cpu.intel.coffee-lake
    inputs.nixos-hardware.nixosModules.common.gpu.nvidia.ampere

    inputs.home-manager.nixosModules.default

    inputs.self.nixosModules.common
    inputs.self.nixosModules.workstation
    inputs.self.nixosModules.desktop

    # inputs.self.nixosModules.gnome
    # inputs.self.nixosModules.kde
    inputs.self.nixosModules.hyprland

    ./disks.nix
  ];

  hardware = {
    initrd.availableKernelModules = [ "nvme" ];
    kernelModules = [ "cpuid" "coretemp" ];
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
  };

  time.timeZone = "Europe/Amsterdam";

  security = {
    protectKernelImage = true;
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

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

  home-manager.useGlobalPkgs = true;
  home-manager.users.lor.imports = [
    inputs.self.homeModules.core
    inputs.self.homeModules.git
    inputs.self.homeModules.dev
    inputs.self.homeModules.helix
    inputs.self.homeModules.neovim
    inputs.self.homeModules.shell
    inputs.self.homeModules.terminal
  ];
}

