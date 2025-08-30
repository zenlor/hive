{ inputs, config, ... }:
{
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

  # NOTE: all this stuff may or not work ...
  # boot params
  # boot.kernelParams = ["nvidia.NVreg_PerserveVideoMemoryAllocations=1"];

  # nvidia Modprobe settings
  # 
  # https://discourse.nixos.org/t/psa-for-those-with-hibernation-issues-on-nvidia/61834
  # https://forums.developer.nvidia.com/t/black-screen-with-cursor-after-sleep/319473/5
  # boot.extraModprobeConfig = ''
  #   options nvidia_modeset vblank_sem_control=0
  #   options nvidia NVreg_PreserveVideoMemoryAllocations=0
  # '';

  # systemd.units.systemd-suspend = {
  #   overrideStrategy = "asDropin";
  #   text = ''
  #     [Service]
  #     Environment="SYSTEMD_SLEEP_FREEZE_USER_SESSIONS=false"
  #   '';
  # };
}
