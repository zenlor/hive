{ lib, modulesPath, config, pkgs, ... }:
let secrets = import ../../nixos/secrets.nix { };
in {
  imports = [ ./_hardware.nix ./_services.nix ];

  time.timeZone = "Europe/Amsterdam";

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

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  networking.firewall.allowPing = false;

  # for some reason fails most of the times
  services.resolved.enable = false;

  # VPS needs quemu guest agent
  environment.systemPackages = [ pkgs.qemu-utils ];
  services.qemuGuest.enable = true;

  # wireguard
  age.secrets.wireguard-key.file = secrets.wireguard.frenz.key;

  networking.firewall.allowedUDPPorts = [ 51820 ];
  networking.nat = {
    enable = true;
    externalInterface = "enp0s3";
    internalInterfaces = [ "wg0" ];
  };

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.69.0.1/24" ];
    listenPort = 51820;
    privateKeyFile = config.age.secrets.wireguard-key.path;

    postSetup = ''
      ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.69.0.0/24 -o enp0s3 -j MASQUERADE
    '';
    postShutdown = ''
      ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.69.0.0/24 -o enp0s3 -j MASQUERADE
    '';

    peers = [
      {
        publicKey = secrets.wireguard.nasferatu.pub;
        allowedIPs = [ "10.69.0.2/32" ];
      }
      {
        publicKey = secrets.wireguard.pad.pub;
        allowedIPs = [ "10.69.0.3/32" ];
      }
      {
        publicKey = secrets.wireguard.horus.pub;
        allowedIPs = [ "10.69.0.4/32" ];
      }
    ];
  };
}
