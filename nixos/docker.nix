{ ... }:
{ lib, pkgs, ... }:
let inherit (lib) mkDefault;
in {
  virtualisation.podman = {
    enable = lib.mkDefault true;
    autoPrune.enable = true;
    dockerCompat = true;
  };
}
