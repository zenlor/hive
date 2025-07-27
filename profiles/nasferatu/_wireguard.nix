{ config, lib, ... }:
let secrets = import ../../nixos/secrets.nix;
in {
  age.secrets.wireguard-key.file = secrets.wireguard.nasferatu.key;
  age.secrets.proton-key.file = secrets.proton.nasferatu.key;

  networking.useNetworkd = true;
  networking.wireguard.useNetworkd = true;
  networking.defaultGateway = # { address = "192.168.178.1"; interface = "enp4s0"; };
  {
    address = "10.2.0.1";
    interface = "proton0";
    # nameservers = ["10.2.0.1"];
  };
  networking.nameservers = ["10.2.0.1"];
  networking.firewall.allowedUDPPorts = [ 51820 51822 ];

  networking.wireguard.interfaces.home0 = {
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

  networking.wireguard.interfaces.proton0 = {
    ips = [secrets.proton.nasferatu.ip];
    listenPort = 51822;
    privateKeyFile = config.age.secrets.proton-key.path;

    peers = [{
      name = "protn";
      publicKey = "C+u+eQw5yWI2APCfVJwW6Ovj3g4IrTOfe+tMZnNz43s=";
      allowedIPs = ["0.0.0.0/0"];
      endpoint = "217.138.216.162:51820";
      persistentKeepalive = 25;
    }];
  };
}
