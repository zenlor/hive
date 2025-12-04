{
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    nvtopPackages.full
  ];

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
    package = config.boot.kernelPackages.nvidiaPackages.beta;
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

  # INFO:
  # - https://yalter.github.io/niri/Nvidia.html
  # - https://github.com/NVIDIA/egl-wayland/issues/126#issuecomment-2379945259
  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json" =
    {
      text = builtins.toJSON {
        rules = [
          {
            pattern = {
              feature = "procname";
              matches = "niri";
            };
            profile = "Limit Free Buffer Pool On Wayland Compositors";
          }
          {
            pattern = {
              feature = "procname";
              matches = "kwin_wayland";
            };
            profile = "Limit Free Buffer Pool On Wayland Compositors";
          }
          {
            pattern = {
              feature = "procname";
              matches = "gnome-shell";
            };
            profile = "Limit Free Buffer Pool On Wayland Compositors";
          }
        ];
        profiles = [
          {
            name = "Limit Free Buffer Pool On Wayland Compositors";
            settings = [
              {
                key = "GLVidHeapReuseRatio";
                value = 1;
              }
            ];
          }
        ];
      };
    };
}
