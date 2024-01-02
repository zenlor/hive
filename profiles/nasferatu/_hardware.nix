{ lib, modulesPath, config, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/78e44984-7ab6-4b80-9744-17cc462ae1a9";
    fsType = "xfs";
    # no access time and continuous TRIM for SSD
    options = [ "noatime" "discard" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/55F0-3C5E";
    fsType = "vfat";
  };

  fileSystems."/tmp/cache" = {
    device = "/dev/disk/by-label/cache";
    fsType = "xfs";
    # no access time and continuous TRIM for SSD
    options = [ "noatime" "discard" ];
  };

  swapDevices = [ ];

  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  # NAS shall consume less electricity
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };
}
