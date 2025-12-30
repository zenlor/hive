{
  pkgs,
  ...
}:
let
  repository = "https://github.com/moolite/marrani.lol.git";
  public-folder = "/srv/www/marrani.lol";
in
{

  systemd.tmpfiles.rules = [
    "d ${public-folder} 0775 root www-data -"
    "d /var/lib/marrani-lol 0775 marrani-lol www-data -"
  ];

  services.caddy.virtualHosts."marrani.lol" = {
    extraConfig = ''
      encode zstd gzip
      root * ${public-folder}
      file_server
    '';
  };

  users.groups.www-data = { };
  users.users.caddy.extraGroups = [ "www-data" ];

  users.groups.marrani-lol = { };
  users.users.marrani-lol = {
    group = "marrani-lol";
    extraGroups = [ "www-data" ];
    home = "/var/lib/marrani-lol";
    isSystemUser = true;
    description = "marrani-lol build user";
  };

  systemd.timers.marrani-lol = {
    description = "run hugo build";
    timerConfig = {
      OnCalendar = "1 minute";
      Persistent = true;
      RandomizedOffsetSec = 10;
    };
  };

  systemd.services.marrani-lol = {
    description = "A very marrano blog";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    path = [ pkgs.marrano-warez ];

    script = ''
      #!/bin/bash

      if [[ ! -d "marrani.lol" ]]; then
        ${pkgs.git}/bin/git clone ${repository}
      fi
      pushd marrani.lol

      ${pkgs.git}/bin/git pull
      ${pkgs.hugo}/bin/hugo --minify || exit 1

      ${pkgs.rsync}/bin/rsync -rv --no-times --delete public/ ${public-folder}
      echo "update finished at: $(date)"
    '';

    serviceConfig = {
      User = "marrani-lol";
      Group = "www-data";
      Type = "oneshot";
      TimeoutStopSec = "45s";
      WorkingDirectory = "/var/lib/marrani-lol";
    };
  };
}
