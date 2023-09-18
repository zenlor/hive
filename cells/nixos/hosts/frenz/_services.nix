{ config
, lib
, pkgs
, ...
}:
{
  environment.systemPackages = [
    pkgs.caddy
  ];

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

  services.marrano-bot = {
    enable = true;
    hostName = "bot.marrani.lol";
    logLevel = "debug";
  };
}
