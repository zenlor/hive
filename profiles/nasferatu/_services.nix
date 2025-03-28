{ ... }:
{

  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
  };

  services.caddy.enable = true;

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
                    <li><a href='http://nasferatu.local:9117/'>Jackett</a></li>
                    <li><a href='http://nasferatu.local:8191/'>Flaresolverr</a></li>
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
    "http://jackett.nasferatu.local" = {
      extraConfig = ''
        reverse_proxy :9117:
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
  };
}
