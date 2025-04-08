{ ... }:
{ pkgs, config, ... }:{
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # boot params
  boot.kernelParams = ["nvidia.NVreg_PerserveVideoMemoryAllocations=1"];
}
