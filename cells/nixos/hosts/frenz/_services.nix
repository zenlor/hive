{ config
, lib
, pkgs
, ...
}:
{
  environment.systemPackages = [
    pkgs.marrano-bot
  ];
}
