{ config, pkgs, ... }:
let
  secrets = import ../../secrets.nix;
in
{
  age.secrets.marrano-warez = {
    file = secrets.services.marrano-warez;
    owner = "marrano-warez";
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

  services.caddy.virtualHosts."i.marrani.lol" = {
    extraConfig = ''
      encode zstd gzip
      reverse_proxy http://127.0.0.1:10009
    '';
  };

  services.caddy.virtualHosts."warez.marrani.lol" = {
    extraConfig = ''
      encode zstd gzip
      reverse_proxy http://127.0.0.1:10009
    '';
  };

  systemd.services.marrano-warez = {
    description = "A very marrano bot";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    path = [ pkgs.marrano-warez ];

    serviceConfig = {
      User = "marrano-warez";
      Group = "marrano-warez";
      Type = "simple";
      Restart = "on-failure";
      EnvironmentFile = config.age.secrets.marrano-warez.path;
      WorkingDirectory = "/var/lib/marrano-warez";
      ExecStart = "${pkgs.marrano-warez}/bin/marrano-warez -addr 127.0.0.1:10009";
    };
  };
}
