{ config, lib, ... }:
let
  secrets = import ../../nixos/secrets.nix;
in
{
  age.secrets.wireguard-key.file = secrets.wireguard.meila.key;

  networking.useNetworkd = true;
  networking.useHostResolvConf = true;
  networking.wireguard.useNetworkd = true;

  networking.firewall.allowedUDPPorts = [ 51820 ];

  networking.wireguard.interfaces.home0 = {
    ips = [ "${secrets.wireguard.meila.ip}/24" ];
    listenPort = 51820;
    privateKeyFile = config.age.secrets.wireguard-key.path;

    peers = [{
      publicKey = lib.readFile secrets.wireguard.frenz.pub;
      allowedIPs = secrets.wireguard.allowedIPs;
      endpoint = secrets.wireguard.endpoint;
      persistentKeepalive = 25;
    }];
  };
}
