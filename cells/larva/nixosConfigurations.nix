{ inputs
, cell
}:
let
  inherit (cell)
    profiles
    ;
in
{
  larva = {
    bee = {
      system = "x86_64-linux";
      pkgs = import inputs.nixos-23-05 {
        inherit (inputs.nixpkgs) system;
      };
    };
    imports = [
      profiles.bootstrap
    ];

    system.stateVersion = "23.05";
  };
}
