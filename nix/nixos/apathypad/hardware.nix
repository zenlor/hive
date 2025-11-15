{ modulesPath
, lib
, config
, ...
}: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/1bb15153-a62a-4035-a72a-3facc48918a3";
    fsType = "xfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/ECBB-FB28";
    fsType = "vfat";
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp59s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Laptop shall consume less electricity
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  # Hardware Acceleration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.hardware.bolt.enable = true;

  # hardware.nvidia = {
  #   open = true;

  #   # config.boot.kernelPackages.nvidiaPackages.nvidia_x11_vulkan_beta;
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;

  #   powerManagement = {
  #     enable = false;
  #     finegrained = false;
  #   };

  #   nvidiaSettings = true;
  #   modesetting.enable = true;
  #   prime = {
  #     # offload.enable = true;
  #     sync.enable = true;
  #     allowExternalGpu = true;
  #     nvidiaBusId = "PCI:7:0:0";
  #     intelBusId = "PCI:0:2:0";
  #   };
  # };
  # services.xserver.videoDrivers = [
  #   "modesetting"
  #   "nvidia"
  # ];

  # hardware.bumblebee = {
  #   enable = true;
  #   connectDisplay = false;
  #   driver = "nvidia";
  # };
  # programs.xwayland.enable = true;

  # Wayland HiDPI settings
  # services.dconf = {
  #   enable = true;
  #   profiles = {
  #     user.database = {};
  #     "org/gnome/mutter" = {
  #       experimental-features=["scale-monitor-framebuffer"];
  #     };
  #   };
  # };
}
