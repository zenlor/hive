{ inputs, ... }:
{ lib, ... }: {

  nixpkgs.overlays = [ inputs.marrano-bot.overlays.default ];

  age.secrets.marrano-bot.file = ../secrets/services/marrano-bot.age;

  services.marrano-bot = {
    enable = lib.mkDefault true;
    hostName = lib.mkDefault "bot.marrani.lol";
    logLevel = lib.mkDefault "debug";
  };
}
