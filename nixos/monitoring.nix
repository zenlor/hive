{ ... }:
{

 services.prometheus = {
    enable = true;
    listenAddress = "0.0.0.0";
    port = 9163;
    retentionTime = "3y";
    scrapeConfigs = [
      {
        job_name = "collectd";
        scrape_interval = "5s";
        scrape_timeout = "3s";
        scheme = "http";
        static_configs = [
          { targets = ["127.0.0.1:59103"]; }
        ];
      }
    ];
  };

  services.collectd = {
    enable = true;
    autoLoadPlugin = true;
    plugins = {
      cpu = ''
        ReportByState true
        ReportByCPU true
        ValuesPercentage false
      '';
      cpusleep = "";
      df = "";
      disk = "";
      memory = "";
      # ipstats = ""; # NOTE: BROKEN
      cgroups = "";
      buddyinfo = "";
      connectivity = "";
      conntrack = "";
      smart = "";
      statsd = ''
        CounterSum true
        TimerPercentile 95
      '';
      write_prometheus = ''
        Host 127.0.0.1
        Port 59103
      '';
    };
  };
}
