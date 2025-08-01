{ ... }: {

  fileSystems."/export/downloads" = {
    device = "/mnt/warez/downloads";
    options = [ "bind" ];
  };
  fileSystems."/export/movies" = {
    device = "/mnt/video/Movies";
    options = [ "bind" ];
  };
  fileSystems."/export/tv" = {
    device = "/mnt/video/TV";
    options = [ "bind" ];
  };
  fileSystems."/export/music" = {
    device = "/mnt/warez/music";
    options = [ "bind" ];
  };
  fileSystems."/export/vault" = {
    device = "/mnt/backup/vault";
    options = [ "bind" ];
  };

  # Fileserver
  services.nfs.server = {
    enable = true;
    exports = ''
      /export/downloads  192.168.178.0/24(rw,fsid=0,no_subtree_check) 10.69.0.0/30(rw,fsid=0,no_subtree_check)
      /export/movies     192.168.178.0/24(rw,fsid=0,no_subtree_check) 10.69.0.0/30(rw,fsid=0,no_subtree_check)
      /export/tv         192.168.178.0/24(rw,fsid=0,no_subtree_check) 10.69.0.0/30(rw,fsid=0,no_subtree_check)
      /export/music      192.168.178.0/24(rw,fsid=0,no_subtree_check) 10.69.0.0/30(rw,fsid=0,no_subtree_check)
      /export/vault      192.168.178.0/24(rw,fsid=0,no_subtree_check) 10.69.0.0/30(rw,fsid=0,no_subtree_check)
    '';
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
  };
  networking.firewall.allowedTCPPorts = [ 111 2049 4000 4001 4002 20048 ];
  networking.firewall.allowedUDPPorts = [ 111 2049 4000 4001 4002 20048 ];

  services.avahi.extraServiceFiles = {
    smb = ''
      <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
      <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
      <service-group>
       <name replace-wildcards="yes">%h</name>
       <service>
        <type>_adisk._tcp</type>
        <txt-record>sys=waMa=0,adVF=0x100</txt-record>
        <txt-record>dk0=adVN=Time Capsule,adVF=0x82</txt-record>
       </service>
       <service>
        <type>_smb._tcp</type>
        <port>445</port>
       </service>
       <service>
        <type>_device-info._tcp</type>
        <txt-record>model=TimeCapsule8,119</txt-record>
      </service>
      </service-group>
    '';
  };

  # Most of the Samba configuration is coppied from dperson/samba container.
  # Note: when adding user do not forge to run `smbpasswd -a <USER>`.
  # services.samba = {
  #   enable = true;
  #   securityType = "user";
  #   settings = ''
  #       workgroup = WORKGROUP
  #       server role = standalone server
  #       dns proxy = no
  #       vfs objects = catia fruit streams_xattr

  #       pam password change = yes
  #       map to guest = bad user
  #       usershare allow guests = yes
  #       create mask = 0664
  #       force create mode = 0664
  #       directory mask = 0775
  #       force directory mode = 0775
  #       follow symlinks = yes
  #       load printers = no
  #       printing = bsd
  #       printcap name = /dev/null
  #       disable spoolss = yes
  #       strict locking = no
  #       aio read size = 0
  #       aio write size = 0
  #       vfs objects = acl_xattr catia fruit streams_xattr
  #       inherit permissions = yes

  #       # Security
  #       client ipc max protocol = SMB3
  #       client ipc min protocol = SMB2_10
  #       client max protocol = SMB3
  #       client min protocol = SMB2_10
  #       server max protocol = SMB3
  #       server min protocol = SMB2_10

  #       # Time Machine
  #       fruit:delete_empty_adfiles = yes
  #       fruit:time machine = yes
  #       fruit:veto_appledouble = no
  #       fruit:wipe_intentionally_left_blank_rfork = yes
  #       fruit:posix_rename = yes
  #       fruit:metadata = stream
  #     '';

  #   shares = {
  #     "Time Capsule" = {
  #       path = "/pool/samba/timemachine";
  #       browseable = "yes";
  #       "read only" = "no";
  #       "inherit acls" = "yes";

  #       # Authenticate ?
  #       # "valid users" = "melias122";

  #       # Or allow guests
  #       "guest ok" = "yes";
  #       "force user" = "nobody";
  #       "force group" = "nogroup";
  #     };
  #     public = {
  #       path = "/pool/samba/public";
  #       browseable = "yes";
  #       "read only" = "no";

  #       # This is public, everybody can access.
  #       "guest ok" = "yes";
  #       "force user" = "nobody";
  #       "force group" = "users";

  #       "veto files" = "/.apdisk/.DS_Store/.TemporaryItems/.Trashes/desktop.ini/ehthumbs.db/Network Trash Folder/Temporary Items/Thumbs.db/";
  #       "delete veto files" = "yes";
  #     };
  #     melias122 = {
  #       path = "/pool/samba/melias122";
  #       browseable = "yes";
  #       "read only" = "no";

  #       # Make this private
  #       "guest ok" = "no";
  #       "valid users" = "melias122";

  #       "veto files" = "/.apdisk/.DS_Store/.TemporaryItems/.Trashes/desktop.ini/ehthumbs.db/Network Trash Folder/Temporary Items/Thumbs.db/";
  #       "delete veto files" = "yes";
  #     };
  #   };
  # };

  services.samba = {
    enable = true;
    openFirewall = true;
    winbindd.enable = true;
    nmbd.enable = true;
    securityType = "user";
    enableNmbd = true;
    enableWinbindd = true;

    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server role" = "standalone server";
        "dns proxy" = "no";
        "vfs objects" = "acl_xattr catia fruit streams_xattr";
        "pam password change" = "yes";
        "map to guest" = "bad user";
        "usershare allow guests" = "yes";
        "create mask" = "0664";
        "force create mode" = "0664";
        "directory mask" = "0775";
        "force directory mode" = "0775";
        "follow symlinks" = "yes";
        "load printers" = "no";
        "printing" = "bsd";
        "printcap name" = "/dev/null";
        "disable spoolss" = "yes";
        "strict locking" = "no";
        "aio read size" = 0;
        "aio write size" = 0;
        "inherit permissions" = "yes";

        # Security
        "client ipc max protocol" = "SMB3";
        "client ipc min protocol" = "SMB2_10";
        "client max protocol" = "SMB3";
        "client min protocol" = "SMB2_10";
        "server max protocol" = "SMB3";
        "server min protocol" = "SMB2_10";

        # Time Machine
        "fruit:delete_empty_adfiles" = "yes";
        "fruit:time machine" = "yes";
        "fruit:veto_appledouble" = "no";
        "fruit:wipe_intentionally_left_blank_rfork" = "yes";
        "fruit:posix_rename" = "yes";
        "fruit:metadata" = "stream";
      };

      downloads = {
        path = "/media/warez/downloads";
        "valid users" = "lor";
        public = "yes";
        writeable = "yes";
        "guest ok" = "yes";
        "force user" = "share";
        "force group" = "share";
        "veto files" = "/.apdisk/.DS_Store/.TemporaryItems/.Trashes/desktop.ini/ehthumbs.db/Network Trash Folder/Temporary Items/Thumbs.db/";
        "delete veto files" = "yes";
      };
      Videos = {
        path = "/media/video";
        "valid users" = "lor";
        public = "yes";
        writeable = "yes";
        "guest ok" = "yes";
        "force user" = "share";
        "force group" = "share";
        "veto files" = "/.apdisk/.DS_Store/.TemporaryItems/.Trashes/desktop.ini/ehthumbs.db/Network Trash Folder/Temporary Items/Thumbs.db/";
        "delete veto files" = "yes";
      };
      Music = {
        path = "/media/warez/music";
        "valid users" = "lor";
        public = "yes";
        writeable = "yes";
        "guest ok" = "yes";
        "force user" = "share";
        "force group" = "share";
        "veto files" = "/.apdisk/.DS_Store/.TemporaryItems/.Trashes/desktop.ini/ehthumbs.db/Network Trash Folder/Temporary Items/Thumbs.db/";
        "delete veto files" = "yes";
      };
      warez = {
        path = "/media/warez";
        "valid users" = "lor";
        public = "yes";
        writeable = "yes";
        "guest ok" = "yes";
        "force user" = "share";
        "force group" = "share";
        "veto files" = "/.apdisk/.DS_Store/.TemporaryItems/.Trashes/desktop.ini/ehthumbs.db/Network Trash Folder/Temporary Items/Thumbs.db/";
        "delete veto files" = "yes";
      };
      Vault = {
        path = "/media/backup/vault";
        "force group" = "share";
        "valid users" = "lor";
        writable = "yes";
        browseable = "yes";
        "read only" = "no";
        "inherit acls" = "yes";
        "vfs objects" = "catia fruit streams_xattr";
        "veto files" = "/.apdisk/.DS_Store/.TemporaryItems/.Trashes/desktop.ini/ehthumbs.db/Network Trash Folder/Temporary Items/Thumbs.db/";
        "delete veto files" = "yes";
      };
      TimeMachine = {
        path = "/media/backup/time_machine";
        "force group" = "share";
        "valid users" = "lor";
        writable = "yes";
        browseable = "yes";
        "read only" = "no";
        "inherit acls" = "yes";
        "fruit:time machine" = "yes";
        "vfs objects" = "catia fruit streams_xattr";
        "veto files" = "/.apdisk/.DS_Store/.TemporaryItems/.Trashes/desktop.ini/ehthumbs.db/Network Trash Folder/Temporary Items/Thumbs.db/";
        "delete veto files" = "yes";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
    discovery = true;
  };
}
