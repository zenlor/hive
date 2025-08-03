{ lib, ... }: {
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
      ratio-limit = 3;
      idle-seeding-limit-enabled = true;

      speed-limit-up = 1024*6;
      speed-limit-down = 1024*500;

      alt-speed-up = 1024*2;
      alt-speed-down = 1024*250;
      alt-speed-time-enabled = true;
      alt-speed-time-begin = 540;
      alt-speed-time-end = 60;
    };
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

    services.sonarr = {
    enable = true;
    user = "share";
    group = "share";
    openFirewall = true;
  };
}
