{ ... }: {

  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
  };

  services.caddy.enable = true;

  services.caddy.globalConfig = ''
    metrics
  '';

  services.caddy.virtualHosts = {
    "http://nasferatu.local" = {
      extraConfig = ''
        header {
          Content-Type text/html;utf-8
          Cache-Control max-age=31536000
          X-Frame-Options DENY
        }
        respond / 200 {
          body "<html>
                <head><title>nasferatu</title></head>
                <body>
                  <ul>
                    <li><a href='http://nasferatu.local:9091/'>Transmission</a></li>
                    <li><a href='http://nasferatu.local:32400/'>Plex</a></li>
                    <li><a href='http://nasferatu.local:8989/'>Sonarr</a></li>
                    <li><a href='http://nasferatu.local:9696/'>Prowlerr</a></li>
                    <li><a href='http://nasferatu.local:8191/'>Flaresolverr</a></li>
                    <li><a href='http://nasferatu.local:9163/'>Prometheus</a></li>
                  </ul>
                </body>
                <html>"
        }
      '';
    };
    "http://transmission.nasferatu.local" = {
      extraConfig = ''
        reverse_proxy :9091:
      '';
    };
    "http://sonarr.nasferatu.local" = {
      extraConfig = ''
        reverse_proxy :8989:
      '';
    };
    "http://prowlerr.nasferatu.local" = {
      extraConfig = ''
        reverse_proxy :9696:
      '';
    };
    "http://flaresolverr.nasferatu.local" = {
      extraConfig = ''
        reverse_proxy :8191:
      '';
    };
    "http://plex.nasferatu.local" = {
      extraConfig = ''
        reverse_proxy :32400:
      '';
    };
    "http://prometheus.nasferatu.local" = {
      extraConfig = ''
        reverse_proxy :9163:
      '';
    };
  };

  services.prometheus.scrapeConfigs = [
    {
      job_name = "caddy";
      scrape_interval = "15s";
      scrape_timeout = "10s";
      static_configs = [
        { targets = [ "127.0.0.1:2019" ]; }
      ];
      metric_relabel_configs = [
        {
          source_labels = [ "__name__" ];
          regex = "go_.*";
          action = "drop";
        }
        {
          source_labels = [ "__name__" ];
          regex = "go_.*";
          action = "drop";
        }
      ];
    }
  ];

  # enable smart
  services.collectd.plugins.smart = "";

  # services.ollama = {
  #   enable = true;
  #   loadModels = ["qwen3:8b" "qwen3:4b"];
  #   openFirewall = true;
  #   host = "0.0.0.0";
  # };
  # services.prometheus.webExternalUrl = "nasferatu.local";
}
