{ ... }:
{

 services.prometheus = {
    enable = true;
    listenAddress = "0.0.0.0";
    retentionTime = "3y";
    scrapeConfigs = [
      {
        jobName = "collectd";
        scrapeInterval = "5s";
        scrapeTimeout = "10s";
        scheme = "http";
        staticConfigs = [
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
      cpufreq = "";
      cpusleep = "";
      df = "";
      disk = "";
      memory = "";
      ipstats = "";
      cgroups = "";
      buddyinfo = "";
      uptime_check = "Type uptime";
      connectivity = "";
      conntrack = "";
      smart = "";
      statsd = ''
        CounterSum true
        TimerPercentile 95
      '';
      prometheus = ''
        Host 127.0.0.1
        Port 59103
      '';
    };
  };
}
