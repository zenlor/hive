{ ... }:
{ lib, ... }: {
  age.secrets.marrano-bot.file = ../secrets/marrano-bot.age;

  services.marrano-bot = {
    enable = lib.mkDefault true;
    hostName = lib.mkDefault "bot.marrani.lol";
    logLevel = lib.mkDefault "debug";
  };
}
