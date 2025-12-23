{
  config,
  lib,
  ...
}:
let
  secrets = import ../../secrets.nix;
  protection = x: ''
    @unverified not header Cookie *${x}*
    handle @unverified {
      header Content-Type text/html
      respond <<EOF
        <script>document.cookie = '${x}=1;Path=/;';window.location.reload();</script>
      EOF 418
    }
  '';
in
{
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
          ${protection "verify-frenz"}

          encode zstd gzip

          header {
            Content-Type text/html;utf-8
            Cache-Control max-age=31536000
            X-Frame-Options DENY
          }

          respond / 200 {
            body <<HTML
              <html>
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
              <html>
            HTML
          }
        '';
      };
      "ip.frenz.click" = {
        extraConfig = ''
          respond "{http.request.remote.host}" 200
        '';
      };
      "www.marrani.lol" = {
        extraConfig = ''
          redir https://marrani.lol
        '';
      };
      "marrani.lol" = {
        # extraConfig = ''
        #   ${protection "verify-marrans"}
        #   redir /.well-known/host-meta* https://social.marrani.lol{uri} permanent  # host
        #   redir /.well-known/webfinger* https://social.marrani.lol{uri} permanent  # host
        #   redir /.well-known/nodeinfo* https://social.marrani.lol{uri} permanent   # host

        #   encode zstd gzip

        #   # respond / 200 {
        #   #   body ""
        #   # }
        #   reverse_proxy http://127.0.0.1:10006 {
        #     flush_interval -1
        #   }
        # '';

        extraConfig = ''
          ${protection "verify-marrans"}

          encode zstd gzip
          reverse_proxy http://127.0.0.1:10007
        '';
      };
      "social.marrani.lol" = {
        extraConfig = ''
          ${protection "verify-socialmarrans"}

          encode zstd gzip
          respond /metrics 404
          reverse_proxy http://127.0.0.1:10006 {
            flush_interval -1
          }
        '';
      };
      "rpg.marrani.lol" = {
        extraConfig = ''
          ${protection "verify-rpgmarrans"}

          encode zstd gzip
          reverse_proxy http://127.0.0.1:30000
        '';
      };
      "stats.frenz.click" = {
        extraConfig = ''
          ${protection "verify-statsmarrans"}

          encode zstd gzip
          reverse_proxy http://127.0.0.1:59123
        '';
      };
      "prometheus.frenz.click" = {
        extraConfig = ''
          ${protection "verify-statsmarrans"}

          encode zstd gzip
          reverse_proxy http://127.0.0.1:9163
        '';
      };
      "git.frenz.click" = {
        extraConfig = ''
          ${protection "verify-programmingmarrans"}

          encode zstd gzip
          reverse_proxy http://127.0.0.1:30005
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
  # services.marrano-bot.logLevel = "debug";
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
      instance-language = [
        "it"
        "en-us"
        "en-gb"
        "ru"
      ];
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
    {
      job_name = "gotosocial";
      metrics_path = "/metrics";
      scrape_interval = "15s";
      scrape_timeout = "10s";
      static_configs = [
        { targets = [ "127.0.0.1:10006" ]; }
      ];
    }
  ];

  age.secrets.marrano-bot.file = ../../../secrets/services/marrano-bot.age;
  services.marrano-bot = {
    enable = true;
    hostName = "bot.marrani.lol";
    logLevel = "debug";
  };

  services.forgejo = {
    enable = true;
    settings = {
      log.LEVEL = "Warn";
      server.ROOT_URL = "https://git.frenz.click";
      server.DOMAIN = "git.frenz.click";
      server.HTTP_PORT = 30005;
    };
  };

  services.writefreely = {
    enable = true;
    host = "marrani.lol";
    nginx.enable = false;
    acme.enable = false;
    settings = {
      server = {
        port = 10007;
        gopher_port = 10008;
      };
      app = {
        site_name = "marrans at lazing";
        site_description = "Resistance is futile! All your pixels belong to us!";
      };
    };
    database.type = "sqlite3";
  };

  # owamp device testing
  services.owamp.enable = true;
  networking.firewall.allowedTCPPorts = [ 861 ];
  networking.firewall.allowedUDPPorts = [ 861 ];
  # systemd.services.owamp.environment = {
  # };
}
