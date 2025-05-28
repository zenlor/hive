{ root, ... }:
{
  services.prometheus = {
    listenAddress = "0.0.0.0";
    port = 9163;
    retentionTime = "730d";
    scrapeConfigs = [
      {
        job_name = "node";
        scrape_interval = "60s";
        scrape_timeout = "30s";
        scheme = "http";
        static_configs = [
          { targets = [ "127.0.0.1:59101" ]; }
          { targets = [ "${root.secrets.wireguard.nasferatu.ip}:59101" ]; }
        ];
      }
      {
        job_name = "wireguard";
        scrape_interval = "60s";
        scrape_timeout = "30s";
        scheme = "http";
        static_configs = [
          { targets = [ "127.0.0.1:59102" ]; }
          { targets = [ "${root.secrets.wireguard.nasferatu.ip}:59102" ]; }
        ];
      }
      {
        job_name = "zfs";
        scrape_interval = "60s";
        scrape_timeout = "30s";
        scheme = "http";
        static_configs = [
          { targets = [ "127.0.0.1:59103" ]; }
          { targets = [ "${root.secrets.wireguard.nasferatu.ip}:59101" ]; }
        ];
      }
    ];
    exporters = {
      node = {
        enable = true;
        port = 59101;
        openFirewall = true;
      };
      wireguard = {
        enable = true;
        port = 59102;
        openFirewall = true;
      };
      zfs = {
        enable = true;
        port = 59103;
        openFirewall = true;
      };
    };
  };
}
