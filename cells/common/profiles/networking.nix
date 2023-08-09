{ inputs
, cell
}: {
  networking.firewall.allowPing = true;
  networking.firewall.logRefusedConnections = lib.mkDefault false;
  networking.useNetworkd = lib.mkDefault true;
  networking.useDHCP = lib.mkDefault true;

  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.network.wait-online.enable = false;
  systemd.services.systemd-networkd.stopIfChanged = false;
  systemd.services.systemd-resolved.stopIfChanged = false;
}
