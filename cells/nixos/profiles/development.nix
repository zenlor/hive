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
  environment = {
    systemPackages = with pkgs; [
      gcc
      clang
      zig
    ];
  };
}
