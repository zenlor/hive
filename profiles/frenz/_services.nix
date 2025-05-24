{ config, lib, ... }: let
  secrets = import ../../nixos/secrets.nix;
in {
  services.caddy = {
    enable = true;
    email = "lorenzo@frenzart.com";

    globalConfig = ''
      metrics {
        per_host
      }
    '';

    virtualHosts = {
      "www.giuliani.me" = {
        extraConfig = ''
          redir https://frenz.click
        '';
      };
      "giuliani.me" = {
        extraConfig = ''
          redir https://frenz.click
        '';
      };
      # lost in time and space
      # "www.frenzart.com" = {
      #   extraConfig = ''
      #     redir https://frenz.click
      #   '';
      # };
      # "frenzart.com" = {
      #   extraConfig = ''
      #     redir https://frenz.click
      #   '';
      # };
      "www.frenz.click" = {
        extraConfig = ''
          redir https://frenz.click
        '';
      };
      "frenz.click" = {
        extraConfig = ''
          header {
            Content-Type text/html;utf-8
            Cache-Control max-age=31536000
            X-Frame-Options DENY
          }

          respond / 200 {
            body "<html>
                  <head><title>frenz.click</title></head>
                  <pre>
                  :::::::::: :::::::::  :::::::::: ::::    ::: :::::::::      ::::::::  :::        ::::::::::: ::::::::  :::    :::
                  :+:        :+:    :+: :+:        :+:+:   :+:      :+:      :+:    :+: :+:            :+:    :+:    :+: :+:   :+:
                  +:+        +:+    +:+ +:+        :+:+:+  +:+     +:+       +:+        +:+            +:+    +:+        +:+  +:+
                  :#::+::#   +#++:++#:  +#++:++#   +#+ +:+ +#+    +#+        +#+        +#+            +#+    +#+        +#++:++
                  +#+        +#+    +#+ +#+        +#+  +#+#+#   +#+         +#+        +#+            +#+    +#+        +#+  +#+
                  #+#        #+#    #+# #+#        #+#   #+#+#  #+#      #+# #+#    #+# #+#            #+#    #+#    #+# #+#   #+#
                  ###        ###    ### ########## ###    #### ######### ###  ########  ########## ########### ########  ###    ###
                  </pre>
                  <html>"
          }
        '';
      };
      "www.marrani.lol" = {
        extraConfig = ''
          redir https://marrani.lol
        '';
      };
      "marrani.lol" = {
        extraConfig = ''
          redir /.well-known/host-meta* https://social.marrani.lol{uri} permanent  # host
          redir /.well-known/webfinger* https://social.marrani.lol{uri} permanent  # host
          redir /.well-known/nodeinfo* https://social.marrani.lol{uri} permanent   # host

          # respond / 200 {
          #   body ""
          # }
          reverse_proxy http://127.0.0.1:10006 {
            flush_interval -1
          }
        '';
      };
      "social.marrani.lol" = {
        extraConfig = ''
          encode zstd gzip
          respond /metrics 404
          reverse_proxy http://127.0.0.1:10006 {
            flush_interval -1
          }
        '';
      };
      "stats.frenz.click" = {
        extraConfig = ''
          reverse_proxy http://127.0.0.1:59123
        '';
      };
      "prometheus.frenz.click" = {
        extraConfig = ''
          reverse_proxy http://127.0.0.1:9163
        '';
      };
    };
  };

  age.secrets.grafana-admin = {
    file = secrets.services.grafana;
    owner = "grafana";
  };

  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 59123;
        domain = "stats.frenz.click";
      };
      security = {
        admin_email = "lorenzo@frenzart.com";
        admin_password = "$__file{${config.age.secrets.grafana-admin.path}}";
      };
    };
  };

  # services.marrano-bot.hostName = "bot.marrani.lol";
  services.marrano-bot.logLevel = "debug";
  # services.marrano-bot.logLevel = "error";

  # tinyproxy
  services.tinyproxy = {
    enable = true;
    settings = {
      Port = 8888;
      Listen = "10.69.0.1";
      Allow = "10.69.0.0/24";
      Timeout = 60;
    };
  };

  services.gotosocial = {
    enable = true;
    openFirewall = true;
    settings = {
      host = "social.marrani.lol";
      account-domain = "marrani.lol";
      application-name = "social.marrani.lol";
      bind-address = "127.0.0.1";
      db-address = "/var/lib/gotosocial/database.sqlite";
      db-type = "sqlite";
      port = 10006;
      protocol = "https";
      storage-local-base-path = "/var/lib/gotosocial/storage";
      instance-language = [ "it" "en-us" "en-gb" "ru" ];
      instance-inject-mastodon-version = true;
      accounts-registration-open = true;
      accounts-reason-required = true;
      accounts-allow-custom-css = true;
      letsencrypt-enabled = false;

      metrics-enabled = true;
      metrics-auth-enabled = false;
    };
  };


  services.prometheus.enable = true;
  services.prometheus.exporters.node.openFirewall = lib.mkForce false;
  services.prometheus.exporters.wireguard.openFirewall = lib.mkForce false;
  services.prometheus.exporters.zfs.openFirewall = lib.mkForce false;
  services.prometheus.scrapeConfigs = [
    {
      job_name = "caddy";
      scrape_interval = "15s";
      scrape_timeout = "10s";
      static_configs = [
        {targets = ["127.0.0.1:2019"]; }
      ];
      metric_relabel_configs = [
        {
          source_labels = [ "__name__" ];
          regex= "go_.*";
          action= "drop";
        } {
          source_labels = [ "__name__" ];
          regex= "go_.*";
          action= "drop";
        }
      ];
    }
    {
      job_name = "gotosocial";
      metrics_path = "/metrics";
      scrape_interval = "15s";
      scrape_timeout = "10s";
      static_configs = [
        {targets = ["127.0.0.1:10006"]; }
      ];
    }
  ];
}
