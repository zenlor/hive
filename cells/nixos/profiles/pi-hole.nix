{ config
, lib
, pkgs
, ...
}:
# https://github.com/notracking/hosts-blocklists
let
  whiteList = [
    "bitbucket.io"
    "bitbucket.org"
    "github.com"
    "gitlab.com"

    "brightcove.com" # for skillshare.com videos
    "paperlesspost.com"
  ];

  downloader = ''
    set -euo pipefail
    set -x

    URL=https://raw.githubusercontent.com/notracking/hosts-blocklists/master
    PATH=${lib.makeBinPath [ pkgs.coreutils pkgs.gnused pkgs.systemd pkgs.wget ]}:$PATH

    for f in hostnames.txt domains.txt ; do
      wget --quiet $URL/$f -O /tmp/$f.tmp
      ${lib.concatStringsSep "\n" (map (e: "sed -i '/${e}/d' /tmp/$f.tmp") whiteList)}
      install -Dm644 /tmp/$f.tmp /var/lib/blackhole/$f
      rm /tmp/$f.tmp
    done

    ${lib.optionalString config.services.dnsmasq.enable ''
      systemctl --no-block reload dnsmasq.service
    ''}
  '';

in
{

  environment.systemPackages = with pkgs; [
    dnsmasq
  ];

  services.dnsmasq = {
    enable = true;
    extraConfig = ''
      domain-needed
      bogus-priv
      no-resolv

      server=1.1.1.1
      server=1.0.0.1

      cache-size=10000
      log-queries
      log-facility=/tmp/dnsmasq-adblock.log
      local-ttl=300

      conf-file=/var/lib/blackhole/domains.txt
      addn-hosts=/var/lib/blackhole/hostnames.txt
    '';
  };

  services.dhcpd4 = {
    enable = true;
    interfaces = [ "eno1" ];
    extraConfig = ''
      option subnet-mask 255.255.255.0;
      option broadcast-address 192.168.1.255;
      option routers 192.168.1.254;
      option domain-name "local";
      option domain-name-servers 192.168.1.1;
      subnet 192.168.1.0 netmask 255.255.255.0 {
        range 192.168.1.150 192.168.1.199;
      }
    '';
  };

  systemd = {
    services.blackhole = {
      description = "Update blackhole lists";
      before = [ "dnsmasq.service" ];
      # we want this to run at least once so dnsmasq doesn't choke due to missing files
      wantedBy = [ "multi-user.target" ];
      script = downloader;
      serviceConfig = rec {
        Type = "oneshot";
        StateDirectory = "blackhole";
        ProtectSystem = "strict";
        ProtectHome = "tmpfs";
        PrivateTmp = true;
      };
    };

    timers.blackhole = {
      description = "Update blackhole lists daily";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "1min";
        OnUnitInactiveSec = "24h";
      };
    };
  };
}
