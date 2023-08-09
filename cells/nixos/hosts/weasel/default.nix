{ inputs
, cell
, ...
}:
let
  inherit (inputs) suites profiles;
  system = "x86_64-linux";
in
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl

    suites.base
    ./_hardware-configuration.nix
  ];

  bee = {
    system = system;
    home = inputs.home;
    pkgs = import inputs.nixos {
      inherit system;
      config.allowUnfree = true;
      overlays = with inputs.cells.common.overlays; [
        common-packages
        latest-overrides
      ];
    };
  };

  wsl = {
    enable = true;
    defaultUser = "lor";
    startMenuLaunchers = false;
    nativeSystemd = true;

    wslConf = {
      network = {
        hostname = "horus";
      };
      automount = {
        enabled = true;
        root = "/mnt";
      };
      interop = {
        appendWindowsPath = false;
      };
      user = "lor";
    };
  };

}
