{ inputs
, cell
}:
let
  inherit (inputs)
    cells
    ;
  system = "aarch64-darwin";
in
{

  config.bee = {
    system = "aarch64-darwin";
    home = inputs.home-manager;
    pkgs = import inputs.nixpkgs {
      inherit (inputs.nixpkgs) system;
      config.allowUnfree = true;
    };
  };
}
