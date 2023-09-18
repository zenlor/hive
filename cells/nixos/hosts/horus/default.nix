{ inputs
, cell
}:
let
  inherit (inputs)
    nixpkgs
    nixos-wsl
    cells
    ;
  inherit (nixpkgs)
    lib
    ;
in
{
  imports = [
    nixos-wsl.nixosModules.wsl

    cell.profiles.core
    cell.profiles.cachix
    cell.profiles.users
    cell.profiles.home
    cell.profiles.wsl
  ];

  config.bee = {
    system = "x86_64-linux";
    home = inputs.home-manager;
    pkgs = import inputs.nixpkgs {
      inherit (inputs.nixpkgs) system;
      config.allowUnfree = true;
      overlays = with cells.packages.overlays; [
        common-packages
        latest-overrides
      ];
    };
  };

  config.wsl = {
    enable = true;
    nativeSystemd = true;

    wslConf = {
      automount.enabled = true;
      boot.systemd = true;

      interop = {
        enabled = true;
        appendWindowsPath = false;
      };

      network = {
        generateHosts = true;
        generateResolvConf = true;
        hostname = "horus";
      };

      user.default = lib.mkForce "lor";
    };
  };
}
