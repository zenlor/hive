{ config, lib, pkgs, ... }: {
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Laptop shall consume less electricity
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };
}
