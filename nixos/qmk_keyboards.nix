{ ... }:
{ pkgs, lib, ... }:
{
  services.udev = {
    packages = with pkgs; [
      qmk
      qmk-udev-rules
      qmk_hid
      via
      vial   
    ];
  };
}
