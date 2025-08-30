{ inputs, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager

    inputs.self.nixosModules.audio
  ];

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        MultiProfile = "multiple";
        ControllerMode = "dual";
        FastConnectable = true;
      };
    };
  };

  hardware.uinput.enable = true;

  hardware.sensor.hddtemp = {
    enable = true;
    unit = "C";
    drives = [ "/dev/disk/by-path/*" ];
  };

  hardware.usbStorage.manageShutdown = true;

  # xbox-like controllers
  hardware.xone.enable = true;

  # bad usb dongles
  hardware.usb-modeswitch.enable = true;

  # steam-controller
  hardware.steam-hardware.enable = true;

  #Flatpak
  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Appimage support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      dina-font
      fira-code
      fira-code-symbols
      ibm-plex
      iosevka-bin
      liberation_ttf
      mplus-outline-fonts.githubRelease
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      proggyfonts
      ubuntu_font_family
      comic-neue
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto" ];
        sansSerif = [ "Noto" ];
        monospace = [ "Iosevka" ];
      };
    };
  };
}
