{ inputs, ... }:
let
  inherit (inputs.nixpkgs)
    self
    config
    lib
    pkgs
    ;
in
{
  programs.fish.useBabelfish = false;
}
