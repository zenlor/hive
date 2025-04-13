{ ... }:
{ pkgs, lib, ... }:
{
  hardware.keyboard.qmk.enable = true;

  environment.systemPackages = with pkgs; [
      qmk
      qmk-udev-rules
      qmk_hid
      via
      vial   
  ];
  services.udev = {
    packages = with pkgs; [
      qmk
      qmk-udev-rules
      qmk_hid
      via
      vial   
    ];
  };

  # Ergodox EZ
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3297", ATTRS{idProduct}=="4975", OWNER="1000", GROUP="100", MODE="0666"
  '';
}
