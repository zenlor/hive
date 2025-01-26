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

  networking.useNetworkd = true;
  networking.hostId = "cda31f1b";
  networking.useDHCP = true;
  networking.hostName = "frenz";
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 25565 35565 ];
  networking.firewall.allowPing = false;
  networking.firewall.trustedInterfaces = [ "wg0" ];

  # for some reason fails most of the times
  services.resolved.enable = false;

  # VPS needs quemu guest agent
  environment.systemPackages = [ pkgs.qemu-utils ];
  services.qemuGuest.enable = true;

  # wireguard
  age.secrets.wireguard-key = {
    file = secrets.wireguard.frenz.key;
    owner = "systemd-network";
  };

  networking.firewall.allowedUDPPorts = [ 51820 ];
  systemd.network = {
    enable = true;
    netdevs = {
      "90-wg0" = {
        enable = true;
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg0";
        };
        wireguardConfig = {
          PrivateKeyFile = config.age.secrets.wireguard-key.path;
          ListenPort = 51820;
        };
        wireguardPeers = [
          # nasferatu
          {
            wireguardPeerConfig = {
              PublicKey = secrets.wireguard.nasferatu.pub;
              AllowedIPs = [ "10.69.0.2" ];
              PersistentKeepalive = 15;
            };
          }
          # pad
          {
            wireguardPeerConfig = {
              PublicKey = secrets.wireguard.pad.pub;
              AllowedIPs = [ "10.69.0.2" ];
              PersistentKeepalive = 15;
            };
          }
          # horus
          {
            wireguardPeerConfig = {
              PublicKey = secrets.wireguard.horus.pub;
              AllowedIPs = [ "10.69.0.4" ];
              PersistentKeepalive = 15;
            };
          }
          # deck
          {
            wireguardPeerConfig = {
              PublicKey = secrets.wireguard.deck.pub;
              AllowedIPs = [ "10.69.0.2" ];
              PersistentKeepalive = 15;
            };
          }

          # marrani
          {
            wireguardPeerConfig = {
              PublicKey = secrets.wireguard.marrani-suppah.pub;
              AllowedIPs = [secrets.wireguard.marrani-suppah.ip];
              PersistentKeepalive = 15;
            };
          }
          {
            wireguardPeerConfig = {
              PublicKey = secrets.wireguard.marrani-krs.pub;
              AllowedIPs = [secrets.wireguard.marrani-krs.ip];
              PersistentKeepalive = 15;
            };
          }
          {
            wireguardPeerConfig = {
              PublicKey = secrets.wireguard.marrani-lukke.pub;
              AllowedIPs = [secrets.wireguard.marrani-lukke.ip];
              PersistentKeepalive = 15;
            };
          }
        ];
      };
    };
    networks = {
      "90-wg0" = {
        enable = true;
        matchConfig.Name = "wg0";
        address = [ "10.69.0.1/24" ];
        networkConfig = {
          IPForward = true;
          IPMasquerade = "ipv4";
        };
      };
    };
  };
}
