{ inputs
, cell
}:
let
  inherit (inputs)
    cells
    ;
in
{
  imports = [
    # cell.profiles.core
    inputs.home-manager.darwinModules.home-manager
    cells.home.users.darwin.lgiuliani
  ];

  config.bee = {
    system = "aarch64-darwin";
    home = inputs.home-manager;
    pkgs = import inputs.nixpkgs {
      inherit (inputs.nixpkgs) system;
      config.allowUnfree = true;
    };
    darwin = inputs.darwin;
  };

  config.services.nix-daemon.enable = true;

  # https://github.com/nix-community/home-manager/issues/4026
  config.users.users.lgiuliani.home = "/Users/lgiuliani";
}
