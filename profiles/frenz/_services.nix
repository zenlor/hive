{ config, lib, pkgs, ... }: {
  environment.systemPackages = [ pkgs.caddy ];

  services.caddy = {
    enable = true;
    email = "lorenzo@frenzart.com";

    virtualHosts = {
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
    };
  };

  # services.marrano-bot.hostName = "bot.marrani.lol";
  # services.marrano-bot.logLevel = "debug";
  services.marrano-bot.logLevel = "error";

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
}
