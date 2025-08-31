{ inputs, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager

    inputs.self.nixosModules.audio
  ];

  environment.systemPackages = with pkgs; [
    firefox
    vlc
    bitwarden-cli
    ghostty
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
    config = {
      preferred = {
        default = "gtk";
      };
    };
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
      useEmbeddedBitmaps = true;
      defaultFonts = {
        serif = [ "Noto" ];
        sansSerif = [ "Noto" ];
        monospace = [ "Iosevka" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };

  # annoying udev rules. Disable autosuspend for HID
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="usbhid", ATTR{power/autosuspend_delay_ms}="-1"
    ACTION=="add", SUBSYSTEM=="usb", ATTR{bInterfaceClass}=="03", ATTR{power/autosuspend_delay_ms}="-1"
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="1532", ATTR{idProduct}=="008d", ATTR{power/autosuspend_delay_ms}="-1"
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="4975", ATTR{power/autosuspend_delay_ms}="-1"
  '';
}
