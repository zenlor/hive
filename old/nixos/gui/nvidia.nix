{ ... }:
{ pkgs, config, lib, ... }: {
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    gsp.enable = true;
    powerManagement.enable = true;
    dynamicBoost.enable = false; # laptop
    videoAcceleration = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

}
