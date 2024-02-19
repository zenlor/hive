{ config, lib, ... }:
let secrets = import ../../nixos/secrets.nix { };
in {

  system.stateVersion = "23.11";

  time.timeZone = "Europe/Rome";

  services.resolved.enable = false;

  wsl = {
    enable = true;
    nativeSystemd = true;

    defaultUser = lib.mkForce "lor";

    wslConf = {
      automount.enabled = true;
      boot.systemd = true;

      interop = {
        enabled = true;
        appendWindowsPath = false;
      };

      network = {
        generateHosts = true;
        generateResolvConf = true; # using systemd-resolvd
        hostname = "horus";
      };

      user.default = lib.mkForce "lor";
    };
  };

  # FIXME load the wireguard module in micro$$$oft kernel :facepalm:
  # age.secrets.wireguard-key.file = secrets.wireguard.horus.key;
  # networking.firewall.allowedUDPPorts = [ 51820 ];
  #
  # networking.wireguard.interfaces.wg0 = _: {
  #   ips = [ "${secrets.wireguard.horus.ip}/24" ];
  #   listenPort = 51820;
  #   privateKeyFile = config.age.secrets.wireguard-key.path;
  #
  #   peers = [{
  #     publicKey = secrets.wireguard.frenz.pub;
  #     allowedIPs = secrets.wireguard.allowedIPs;
  #     endpoint = secrets.wireguard.endpoint;
  #     persistentKeepalive = 25;
  #   }];
  # };
}
