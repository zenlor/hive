{ config, lib, pkgs, cell, ... }: {

  age.secrets.wireguard-key.file = cell.secrets.wireguard.nasferatu.key;

  networking.firewall.allowedUDPPorts = [ 51820 ];

  networking.wireguard.interfaces.wg0 = {
    ips = [ "${cell.secrets.wireguard.nasferatu.ip}/24" ];
    listenPort = 51820;
    privateKeyFile = config.age.secrets.wireguard-key.path;

    peers = [{
      publicKey = cell.secrests.wireguard.frenz.pub;
      allowedIPs = cell.secrets.wireguard.allowedIPs;
      endpoint = cell.secrets.wireguard.endpoint;
      persistentKeepalive = 25;
    }];
  };
}
