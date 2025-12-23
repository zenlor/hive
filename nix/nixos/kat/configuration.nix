{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.self.nixosModules.common
    inputs.self.nixosModules.workstation
    inputs.self.nixosModules.desktop
    inputs.self.nixosModules.amd
    inputs.self.nixosModules.steam

    inputs.self.nixosModules.gnome
    # inputs.self.nixosModules.hyprland
    inputs.self.nixosModules.niri

    ./disks.nix
    ./home.nix
  ];

  networking.hostName = "kat";

  # boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelPackages =
    inputs.nix-cachyos-kernel.legacyPackages.x86_64-linux.linuxPackages-cachyos-latest;

  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
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
      consoleMode = "keep";
      editor = true;
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
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  networking.networkmanager.enable = true;
}
