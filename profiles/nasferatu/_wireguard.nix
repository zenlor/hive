{ config, lib, ... }:
let secrets = import ../../nixos/secrets.nix;
in {
  age.secrets.wireguard-key.file = secrets.wireguard.nasferatu.key;
  age.secrets.proton-key.file = secrets.proton.nasferatu.key;

  networking.firewall.allowedUDPPorts = [ 51820 ];

  networking.wireguard.interfaces.wg0 = {
    ips = [ "${secrets.wireguard.nasferatu.ip}/24" ];
    listenPort = 51820;
    privateKeyFile = config.age.secrets.wireguard-key.path;

    peers = [{
      publicKey = lib.readFile secrets.wireguard.frenz.pub;
      allowedIPs = secrets.wireguard.allowedIPs;
      endpoint = secrets.wireguard.endpoint;
      persistentKeepalive = 25;
    }];
  };

  networking.wireguard.interfaces.wg1 = {
    ips = [ "10.2.0.2/32" ];
    listenPort = 51820;
    privateKeyFile = config.age.secrets.proton-key.path;

    peers = [{
      publicKey = "C+u+eQw5yWI2APCfVJwW6Ovj3g4IrTOfe+tMZnNz43s=";
      allowedIPs = "0.0.0.0/0";
      endpoint = "217.138.216.162:51820";
      persistentKeepalive = 25;
    }];
  };
}
