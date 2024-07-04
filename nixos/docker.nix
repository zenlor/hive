{ ... }:
{ lib, ... }:
{
  virtualisation.podman = {
    enable = lib.mkDefault true;
    autoPrune.enable = true;
    dockerCompat = true;
  };
}
