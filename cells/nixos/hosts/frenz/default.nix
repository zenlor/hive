{ inputs
, cell
}:
let
  inherit (inputs)
    cells
    ;
  system = "x86_64-linux";
in
{
  imports = [
    cell.profiles.cachix
    cell.profiles.core
    cell.profiles.home
    cell.profiles.marrano-bot
    cell.profiles.networking
    cell.profiles.openssh
    cell.profiles.shell

    ./_hardware.nix
    ./_services.nix

    cells.home.users.nixos.lor-server
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
  };

  # OVH boots using grub
  config.boot.loader = {
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

  config.security = {
    protectKernelImage = true;
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  config.networking.hostId = "cda31f1b";
  config.networking.useDHCP = true;
  config.networking.hostName = "frenz";
  config.networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];

  config.networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 ];
    allowedUDPPorts = [ 51820 ];
    allowPing = false;
  };

  # for some reason fails most of the times
  config.services.resolved.enable = false;

  # VPS needs quemu guest agent
  config.environment.systemPackages = with inputs.nixpkgs; [ qemu-utils ];
  config.services.qemuGuest.enable = true;
}
