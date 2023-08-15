{ inputs
, cell
}:
let
  inherit (inputs.nixpkgs)
    self
    config
    lib
    pkgs
    ;
in
{ config, lib, pkgs, ... }:

{
  imports = [
    inputs.marrano-bot.nixosModules.default
  ];

  age.secrets.marrano-bot.file = ../secrets/marrano-bot.age;
}
