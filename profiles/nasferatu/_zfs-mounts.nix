{ ... }: {
  boot.supportedFilesystems = [ "zfs" "xfs" ];

  boot.zfs.extraPools = [ "tank" ];
  services.zfs = {
    trim.enable = true;
    autoScrub.pools = [ "tank" ];
  };

  # re-mint permissions on boot
  systemd.tmpfiles.rules = [
    "d /tmp/cache 777 root root"
    "d /media/video 775 share share"
    "d /media/backup 775 share share"
    "d /media/warez/vault 775 transmission share"
    "d /media/warez/downloads 775 transmission share"
  ];
}
