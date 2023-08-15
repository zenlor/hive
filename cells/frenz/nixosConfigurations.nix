{ inputs
, cell
}:
let
  inherit (inputs)
    cells
    ;
in
{
  frenz = {
    imports = [
      cells.nixos.profiles.core
      cells.nixos.profiles.networking
      cells.nixos.profiles.openssh
      cells.nixos.profiles.cachix
      cells.nixos.profiles.users
      cells.nixos.profiles.home
      cells.nixos.profiles.marrano-bot

      ./_hardware.nix
      ./_services.nix
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

    # OVH boots using grub
    boot.loader = {
      efi = {
        canTouchEfiVariables = false;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        efiSupport = true;
        device = "nodev";
        devices =
          [ "/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_drive-scsi0-0-0-0" ];
        efiInstallAsRemovable = true;
      };
    };

    security = {
      protectKernelImage = true;
      rtkit.enable = true;
      sudo.wheelNeedsPassword = false;
    };

    networking.hostId = "cda31f1b";
    networking.useDHCP = true;
    networking.hostName = "frenz";
    networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ];
      allowedUDPPorts = [ 51820 ];
      allowPing = false;
    };

    # for some reason fails most of the times
    services.resolved.enable = false;

    # VPS needs quemu guest agent
    environment.systemPackages = with inputs.nixpkgs; [ qemu-utils ];
    services.qemuGuest.enable = true;
  };
}
