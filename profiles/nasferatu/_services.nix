{ config
, lib
, pkgs
, ...
}:

{

  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
  };

  services.caddy.enable = true;

  services.caddy.virtualHosts = {
    default = {
      extraConfig = ''
        header {
          Content-Type text/html;utf-8
          Cache-Control max-age=31536000
          X-Frame-Options DENY
        }
        respond / 200 {
          body "<html>
                <head><title>nasferatu</title></head>
                <pre>
                </pre>
                <ul>
                  <li><a href=':9091/'>Transmission</a></li>
                  <li><a href=':8989/'>Sonarr</a></li>
                  <li><a href=':9117/'>Jackett</a></li>
                  <li><a href=':8191/'>Flaresolverr</a></li>
                </ul>
                <html>"
        }
      '';
    };
    "nasferatu.local" = {
      extraConfig = ''
        header {
          Content-Type text/html;utf-8
          Cache-Control max-age=31536000
          X-Frame-Options DENY
        }
        respond / 200 {
          body "<html>
                <head><title>nasferatu</title></head>
                <pre>
                </pre>
                <ul>
                  <li><a href='transmission.nasferatu.local'>Transmission</a></li>
                  <li><a href='sonarr.nasferatu.local'>Sonarr</a></li>
                  <li><a href='jackett.nasferatu.local'>Jackett</a></li>
                  <li><a href='flaresolverr.nasferatu.local'>Flaresolverr</a></li>
                </ul>
                <html>"
        }
      '';
    };
    "transmission.nasferatu.local" = {
      extraConfig = ''
        reverse_proxy :9091:
      '';
    };
    "sonarr.nasferatu.local" = {
      extraConfig = ''
        reverse_proxy :8989:
      '';
    };
    "jackett.nasferatu.local" = {
      extraConfig = ''
        reverse_proxy :9117:
      '';
    };
    "flaresolverr.nasferatu.local" = {
      extraConfig = ''
        reverse_proxy :8191:
      '';
    };
  };
}
