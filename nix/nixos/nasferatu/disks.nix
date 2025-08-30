{ pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  hardware.cpu.amd.updateMicrocode = true;

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
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

  boot.supportedFilesystems = [ "zfs" "xfs" ];

  boot.zfs.extraPools = [ "tank" ];
  services.zfs = {
    trim.enable = true;
    autoScrub.pools = [ "tank" ];
  };

  # re-mint permissions on boot
  systemd.tmpfiles.rules = [
    "d /tmp/cache 777 root root"
    "d /media/video 775 share share"
    "d /media/backup 775 share share"
    "d /media/warez/vault 775 transmission share"
    "d /media/warez/downloads 775 transmission share"
  ];
}
