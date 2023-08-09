{ inputs
, cell
}:
let
  inherit (inputs.pkgs) config;
in
{
  options.zenlor.marrano-bot = {
    enable = mkEnableOption "Enable marrano-bot";

    configFile = {
      type = types.str;
      description = "bot configuration file.";
    };

    useCaddy = {
      type = types.bool;
    };
  };

  config =
    mkIf cfg.enable
      {
        users = {
          users."${cfg.user}" = {
            group = "${cfg.group}";
          };
          groups."${cfg.group}" = { };
        };

        systemd.services.marrano-bot = {
          description = "A very marrano bot.";
          after = [ "network-online.target" "caddy.service" ];
          wantedBy = [ "multi-user.target" ];
          serviceConfig = {
            ExecStart = "${cfg.package}/bin/marrano-bot -Dconfig=${cfg.configFile}";
            Group = cfg.group;
            User = cfg.user;
          };
        };
      };
}
