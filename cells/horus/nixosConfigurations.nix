{ inputs
, cell
}:
let
  inherit (inputs)
    nixos-wsl
    cells
    ;
in
{
  horus = { pkgs, lib, ... }: {
    imports = [
      nixos-wsl.nixosModules.wsl

      cells.nixos.profiles.core
      cells.nixos.profiles.cachix
      cells.nixos.profiles.users
      cells.nixos.profiles.home
    ];

    bee = {
      system = "x86_64-linux";
      home = inputs.home-manager;
      pkgs = import inputs.nixos {
        inherit (inputs.nixpkgs) system;
        config.allowUnfree = true;
        overlays = with cells.packages.overlays; [
          common-packages
          latest-overrides
        ];
      };
    };

    wsl = {
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
  };
}
