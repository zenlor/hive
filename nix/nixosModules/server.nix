{ pkgs, ... }:
{

  environment.etc."fail2ban/filter.d/caddy-unauthorized.local".text = ''
    [Definition]
    failregex = ^.*"remote_ip":"<HOST>",.*?"status":(?:401|403|502),.*$
    ignoreregex =
    datepattern = LongEpoch
  '';
  services.fail2ban = {
    enable = true;
    ignoreIP = [
      "10.0.0.0/8"
      "172.16.0.0/12"
      "192.168.0.0/16"
      "2001:1c00:3406:7b00:6cf7:7adb:c2d:741f"
      "31.151.68.106"
    ];
    bantime = "5m";
    maxretry = 5;

    jails = {
      caddy-unauthorized = {
        settings = {
          enabled = true;
          filter = "caddy-unauthorized";
          port = "http,https";
          logpath = "/var/log/caddy/*.access.log";
          maxretry = 10;
        };
        filter = {
        };
      };
    };
  };

  # services.openssh.settings.LogLevel = "VERBOSE";

  environment.systemPackages = with pkgs; [
    lnav
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
  };
}
