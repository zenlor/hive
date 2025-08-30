{ pkgs, ... }:
{
  boot.plymouth = {
    enable = true;
    font = "${pkgs.noto-fonts}/share/fonts/noto/NotoSans[wdth,wght].ttf";
    extraConfig = ''
      DeviceScale=2
    '';
    theme = "details";
  };

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
