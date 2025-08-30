{ lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "plexmediaserver"
  ];

  services.plex = {
    enable = true;
    openFirewall = true;
    user = "share";
  };

  services.transmission = {
    enable = true;
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
}

