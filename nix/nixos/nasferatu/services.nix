{ lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "plexmediaserver"
    ];

  services.plex = {
    enable = true;
    openFirewall = true;
    user = "share";
  };

  services.deluge = {
    enable = true;
    user = "share";
    group = "share";
    config = {
      download_location = "/media/warez/downloads";
      share_ratio_limit = "5.0";
      max_active_limit = 8;
      daemon_port = 58846;
    };
    web.enable = true;
    web.openFirewall = true;
    openFirewall = true;
  };

  services.transmission = {
    enable = false;
    user = "share";
    group = "share";
    downloadDirPermissions = "755";

    settings = {
      download-dir = "/media/warez/downloads";
      rpc-bind-address = "0.0.0.0";
      rpc-host-whitelist = "*";
      rpc-whitelist-enabled = lib.mkForce true;
      rpc-whitelist = "127.0.0.1,192.168.*.*,10.*.*.*";
      preallocation = 1;
      incomplete-dir-enabled = false;

      # limits
      ratio-limit = 10;
      idle-seeding-limit-enabled = true;

      speed-limit-up = 1024 * 6;
      speed-limit-down = 1024 * 500;

      alt-speed-up = 1024 * 2;
      alt-speed-down = 1024 * 250;
      alt-speed-time-enabled = true;
      alt-speed-time-begin = 540;
      alt-speed-time-end = 60;
    };
  };

  # Sonarr
  services.sonarr = {
    enable = true;
    openFirewall = true;
    user = "share";
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  virtualisation.oci-containers.containers.flaresolverr = {
    image = "ghcr.io/flaresolverr/flaresolverr:v3.2.1";
    autoStart = true;
    ports = [ "8191:8191" ];
    extraOptions = [ "--name=flaresolverr" ];
  };
  networking.firewall.allowedTCPPorts = [ 8191 ];
}
