{ ... }:
{ lib, pkgs, ... }:
let inherit (lib) mkDefault mkForce;
in {
  networking.firewall.allowPing = mkDefault false;
  networking.firewall.logRefusedConnections = mkDefault false;

  networking.useNetworkd = mkDefault false;
  networking.useDHCP = mkDefault true;
  systemd.network.wait-online.enable = mkDefault true;

  services.resolved = {
    enable = mkDefault true;
    dnssec = mkDefault "true";
    dnsovertls = "true";
    domains = [ "~." ];
    fallbackDns = mkDefault [ "1.1.1.1" "1.0.0.1" ];
  };

  networking.firewall.allowedTCPPorts = [ 53 ];
  networking.firewall.allowedUDPPorts = [ 53 ];
}
