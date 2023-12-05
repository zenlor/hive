{ inputs
, cell
}:
let
  inherit (cell)
    profiles
    ;
in
{
  config.bee = {
    system = "x86_64-linux";
    pkgs = import inputs.nixos-23-11 {
      inherit (inputs.nixpkgs) system;
    };
  };

  imports = [
    profiles.bootstrap
  ];

  config.system.stateVersion = "23.11";
}
