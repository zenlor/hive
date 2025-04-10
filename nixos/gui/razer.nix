{ ... }:
{ pkgs, lib, ... }: {
  hardware.openrazer = {
    enable = true;
    users = ["lor"];
  };

  environment.systemPackages = with pkgs; [
    openrazer-daemon
    polychromatic
  ];
}
