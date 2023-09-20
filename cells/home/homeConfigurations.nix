{ inputs, cell }:
let
  inherit (cell)
    profiles
    ;
  bee = {
    inherit (inputs.nixpkgs)
      system;
    home = inputs.home-manager;
  };
in
{
  lor = {
    inherit bee;
    inports = [ profiles.nixos.lor ];
  };
}
