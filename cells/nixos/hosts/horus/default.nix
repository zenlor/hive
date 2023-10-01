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
    cell.profiles.development
    cell.profiles.home
    cell.profiles.shell
    cell.profiles.wsl

    cells.home.users.nixos.lor
    cells.home.users.nixos.root
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
    wsl = inputs.nixos-wsl;
  };

  config.time.timeZone = "Europe/Rome";

  config.wsl = {
    enable = true;
    nativeSystemd = true;

    defaultUser = lib.mkForce "lor";

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

  # fix wsl default user
  config.users.users.lor.uid = 1000;

  config.hardware.opengl.enable = true;
}
