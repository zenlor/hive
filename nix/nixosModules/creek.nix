{...}: {
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # Transmission
  services.transmission = {
    settings = {
      rpc-port = 9091;
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist-enabled = "false";
    };
    openPeerPorts = true;
    openRPCPort = true;
  };

  services.deluge = {
    enable = false;
    web.enable = true;
    web.openFirewall = true;
    openFirewall = true;
    user = "deluge";
  };

  # Sonarr
  services.sonarr = {
    enable = true;
    openFirewall = true;
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  virtualisation.oci-containers.containers.flaresolverr = {
    image = "ghcr.io/flaresolverr/flaresolverr:v3.2.1";
    autoStart = true;
    ports = ["8191:8191"];
    extraOptions = ["--name=flaresolverr"];
  };
  networking.firewall.allowedTCPPorts = [8191];
}
