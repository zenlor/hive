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
  horus = { pkgs, ... }: {
    imports = [
      # nixos-wsl.nixosModules.wsl

      cells.nixos.profiles.core
      # cells.nixos.profiles.networking
      # cells.nixos.profiles.openssh
      cells.nixos.profiles.cachix
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

    # wsl = {
    #   enable = true;
    #   nativeSystemd = true;

    #   boot = {
    #     command = "";
    #     systemd = true;
    #   };

    #   interop = {
    #     enabled = true;
    #     appendWindowsPath = false;
    #   };

    #   network = {
    #     generateHosts = true;
    #     generateResolvConf = true;
    #     hostname = "weasel";
    #   };

    #   automount = {
    #     enabled = true;
    #     root = "/mnt";
    #   };

    #   user = {
    #     default = "lor";
    #   };
    # };
    #

    # FIXME this is to let the check work
    boot.loader.grub.devices = [ "/dev/none" ];
    fileSystems."/" =
      {
        device = "/dev/disk/by-uuid/737459fa-eab9-4d8f-9a14-c8c32d403c08";
        fsType = "btrfs";
        options = [ "subvol=root" ];
      };
  };
}
