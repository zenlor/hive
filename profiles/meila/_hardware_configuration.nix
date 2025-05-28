{ modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "sd_mod"
    "usb_storage"
    "usbhid"
  ];
  boot.kernelModules = [ "kvm-intel" "nvidia" ];
  boot.extraModulePackages = [ ];
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/f1a4b5a3-9386-4984-8eee-0d0037d2a7cd";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=/nixos" ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/f1a4b5a3-9386-4984-8eee-0d0037d2a7cd";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=/home" ];
    };
    "/var" = {
      device = "/dev/disk/by-uuid/f1a4b5a3-9386-4984-8eee-0d0037d2a7cd";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=/var" ];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/f1a4b5a3-9386-4984-8eee-0d0037d2a7cd";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=/nix" ];
    };
    "/swap" = {
      device = "/dev/disk/by-uuid/f1a4b5a3-9386-4984-8eee-0d0037d2a7cd";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=/swap" ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/33E7-115F";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

    "/media/gms" = {
      device = "/dev/disk/by-uuid/2e0e8f78-dee3-444d-979e-8e6ada496e8a";
      fsType = "btrfs";
      options = [ "noatime" "ssd" ];
    };
    "/media/pny" = {
      device = "/dev/disk/by-uuid/f38bc6be-2f1b-469c-a18c-546587debf1b";
      fsType = "btrfs";
      options = [ "noatime" "ssd" ];
    };
    "/media/due" = {
      device = "/dev/disk/by-uuid/428C5FD38C5FBFD9";
      fsType = "ntfs";
      options = [ "noatime" "fmask=0022" "dmask=0022" "uid=lor" "gid=users" ];
    };
  };

  swapDevices = [{ device = "/swap/swapfile"; }];

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Disable = "HandsFree";
      };
    };
  };

  # have fun: https://www.kernel.org/doc/html/v4.12/input/uinput.html
  hardware.uinput.enable = true;

  hardware.sensor.hddtemp = {
    enable = true;
    unit = "C";
    drives = [ "/dev/disk/by-path/*" ];
  };

  # manage external storage spindown/shutdown
  hardware.usbStorage.manageShutdown = true;

  # xbox controllers laying around
  hardware.xone.enable = true;

  # crap usb dongles
  hardware.usb-modeswitch.enable = true;
}
