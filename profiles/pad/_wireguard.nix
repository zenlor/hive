{ config, lib, pkgs, ... }:
let secrets = import ../../nixos/secrets.nix { };
in {
  age.secrets.wireguard-key.file = secrets.wireguard.pad.key;

  networking.firewall.allowedUDPPorts = [ 51820 ];

  networking.wireguard.interfaces.wg0 = {
    ips = [ "${secrets.wireguard.pad.ip}/24" ];
    listenPort = 51820;
    privateKeyFile = config.age.secrets.wireguard-key.path;

    peers = [{
      publicKey = secrets.wireguard.frenz.pub;
      allowedIPs = secrets.wireguard.allowedIPs;
      endpoint = secrets.wireguard.endpoint;
      persistentKeepalive = 25;
    }];
  };
}
