{ ... }:
{ lib, pkgs, ... }:
let inherit (lib) mkDefault mkForce;
in {
  networking.firewall.allowPing = mkDefault false;
  networking.firewall.logRefusedConnections = mkDefault false;

  networking.useNetworkd = mkDefault false;
  networking.useDHCP = mkDefault true;

  systemd.network.wait-online.enable = true;

  services.resolved = {
    enable = mkDefault true;
    dnssec = "allow-downgrade";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1" "1.0.0.1" ];
    extraConfig = ''
      DNSOverTLS=yes
    '';
  };
}
