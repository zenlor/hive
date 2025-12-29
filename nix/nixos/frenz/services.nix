{
  config,
  lib,
  pkgs,
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
      "marrani.lol" = {
        extraConfig = ''
          encode zstd gzip
          reverse_proxy http://127.0.0.1:10007
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
    admin.name = "zenlor";
    settings = {
      server = {
        port = 10007;
        gopher_port = 10008;
      };
      app = {
        site_name = "marrans at lazing";
        site_description = "Resistance is futile! All your pixels belong to us!";
        wf_modesty = true;
        monetization = true;
        federation = true;
        min_username_len = 3;
        editor = "pad";
        public_stats = true;
      };
    };
    database.type = "sqlite3";
  };

  services.webdav = {
    enable = true;
    settings = {
      address = "127.0.0.1";
      port = 10009;
      behindProxy = true;
      prefix = "/";
      directory = "/srv/public";
      modify = true;
      auth = true;
      users = [
        {
          # FIXME: temporary
          username = "admin";
          password = "admin123";
          permissions = "CRUD";
        }
      ];
      cors = {
        enabled = true;
        credentials = true;
        allowed_headers = [ "Depth" ];
        allowed_hosts = [ "https://marrani.lol" ];
        allowed_methods = [ "GET" ];
        exposed_headers = [
          "Content-Length"
          "Content-Range"
        ];
      };
    };
  };

  users.groups.marrano-warez = { };
  users.users = {
    marrano-warez = {
      group = "marrano-warez";
      home = "/var/lib/marrano-warez";
      isSystemUser = true;
      description = "marrano-warez daemon user";
    };
  };

  system.activationScripts.marrano-warez = ''
    mkdir -m 1700 -p /var/lib/marrano-warez
    chown -R marrano-warez:marrano-warez /var/lib/marrano-warez
  '';

  services.caddy.virtualHosts."warez.marrani.lol" = {
    extraConfig = ''
      encode zstd gzip
      reverse_proxy http://127.0.0.1:10008
    '';
  };

  systemd.services.marrano-warez = {
    description = "A very marrano bot";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    path = [ pkgs.marrano-warez ];

    environment = {
      USERNAME = "warez";
      PASSWORD = "marrani";
    };

    serviceConfig = {
      User = "marrano-warez";
      Group = "marrano-warez";
      Type = "simple";
      Restart = "on-failure";
      WorkingDirectory = "/var/lib/marrano-warez";
      ExecStart = "${pkgs.marrano-warez}/bin/marrano-warez -addr 127.0.0.1:10008";
    };
  };
}
