{ inputs, ... }:
{ pkgs, ... }:
{
  imports = [
    inputs.marrano-bot.nixosModules.default
  ];

  age.secrets.marrano-bot.file = ../secrets/marrano-bot.age;
}
