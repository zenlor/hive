{ inputs
, cell
, ...
}:
let
  system = "x86_64-linux";
in
{
  imports = [ ];
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

    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ];
      allowedUDPPorts = [ 51820 ];
      allowPing = false;
    };

    services.resolved = {
      enable = true;
      dnssec = "allow-downgrade";
      domains = [ "~." ];
      fallbackDns = [ "1.1.1.1" "1.0.0.1" ];
      extraConfig = ''
        DNSOverTLS=yes
      '';
    };

    # VPS needs quemu guest agent
    environment.systemPackages = with inputs.nixpkgs; [ qemu-utils ];
    services.qemuGuest.enable = true;

    system.stateVersion = "23.05";
  };
}
