{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager

    inputs.self.nixosModules.audio
  ];

  boot.plymouth = {
    enable = true;
    # font = "${pkgs.noto-fonts}/share/fonts/noto/NotoSans[wdth,wght].ttf";
    extraConfig = ''
      DeviceScale=1
    '';
    theme = "spinner";
  };

  environment.systemPackages = with pkgs; [
    deluge
    vlc
    kitty
    ungoogled-chromium
    firefox
    bitwarden-cli
    bitwarden-desktop
    bws
    flare-signal
  ];

  services.udisks2.enable = true;

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
        # MultiProfile = "multiple";
        Disable = "Handsfree";
        ControllerMode = "dual";
        FastConnectable = true;
      };
    };
  };

  services.blueman.enable = true;

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
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      preferred = {
        default = "gnome";
      };
    };
  };

  services.accounts-daemon.enable = true;

  # Appimage support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # X11/Wayland
  programs.xwayland = {
    enable = true;
  };

  # fonts
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      dina-font
      fira-code-symbols
      ibm-plex
      iosevka-bin
      liberation_ttf
      noto-fonts
      noto-fonts-color-emoji
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
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="4974", ATTR{power/autosuspend_delay_ms}="-1"
  '';

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
