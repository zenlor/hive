{ pkgs, ... }:
{
  # boot.kernelPackages = pkgs.linuxPackages_zen; # NOTE: broken nvidia
  #

  # optimise store when building
  nix.settings.auto-optimise-store = true;
  # run gc weekly
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.extraOptions = let GB = 1024*1024*1024; in ''
    min-free = ${toString (1 * GB)}
    max-free = ${toString (10 * GB)}
  '';

  documentation.dev.enable = true;
  documentation.man = {
    generateCaches = true;
    man-db.enable = false;
    mandoc.enable = true;
  };

  ##
  # QMK/Via
  ##
  hardware.keyboard.qmk.enable = true;
  environment.systemPackages = with pkgs; [
    qmk

    # NOTE: qmk .. actually PYTHON sucks, try installing it using:
    # git clone --depth=0 https://github.come/qmk/qmk_firmware.git
    # pipx install qmk
    # pipx inject qmk -r ~/qmk_firmware/requirements.txt
    pipx

    qmk-udev-rules
    qmk_hid
    via
  ];
  services.udev = {
    packages = with pkgs; [
      qmk
      qmk-udev-rules
      qmk_hid
      via
    ];
  };

  # Ergodox EZ
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3297", ATTRS{idProduct}=="4975", OWNER="1000", GROUP="100", MODE="0666"
  '';

  # enable mDNS
  services.avahi = {
    enable = true;
    openFirewall = true;
    wideArea = true;
  };
}
