{ inputs
, cell
}:
let
  inherit (inputs.nixpkgs)
    lib
    ;
in
{
  networking.firewall.allowPing = lib.mkDefault true;
  networking.firewall.logRefusedConnections = lib.mkDefault false;

  networking.useNetworkd = lib.mkDefault false;
  networking.useDHCP = lib.mkDefault true;

  systemd.network.wait-online.enable = true;


  services.resolved = {
    enable = lib.mkDefault true;
    dnssec = "allow-downgrade";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1" "1.0.0.1" ];
    extraConfig = ''
      DNSOverTLS=yes
    '';
  };
}
