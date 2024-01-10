{ ... }: {
  services.samba = {
    enable = true;
    openFirewall = true;
    enableWinbindd = false;
    enableNmbd = true;
    securityType = "user";

    extraConfig = ''
      workgroup = WORKGROUP
      server string = nasferatu
      netbios name = nasferatu
      security = user
      hosts allow = 10.69.0. 192.168.1. 127.0.0.1 localhost ::1
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user

      min protocol = SMB2
      vfs objects = acl_xattr catia fruit streams_xattr
      fruit:nfs_aces = no
      inherit permissions = yes

      fruit:model = MacSamba
      fruit:posix_rename = yes
      fruit:veto_appledouble = no
      fruit:wipe_intentionally_left_blank_rfork = yes
      fruit:delete_empty_adfiles = yes
      fruit:metadata = stream
    '';

    shares = {
      downloads = {
        path = "/media/warez/downloads";
        "valid users" = "lor";
        public = "yes";
        writeable = "yes";
        "guest ok" = "yes";
        "force user" = "share";
        "force group" = "share";
      };
      Movies = {
        path = "/media/video/Movies";
        "valid users" = "lor";
        public = "yes";
        writeable = "yes";
        "guest ok" = "yes";
        "force user" = "share";
        "force group" = "share";
      };
      TV = {
        path = "/media/video/TV";
        "valid users" = "lor";
        public = "yes";
        writeable = "yes";
        "guest ok" = "yes";
        "force user" = "share";
        "force group" = "share";
      };
      Music = {
        path = "/media/warez/music";
        "valid users" = "lor";
        public = "yes";
        writeable = "yes";
        "guest ok" = "yes";
        "force user" = "share";
        "force group" = "share";
      };
      warez = {
        path = "/media/warez";
        "valid users" = "lor";
        public = "yes";
        writeable = "yes";
        "guest ok" = "yes";
        "force user" = "share";
        "force group" = "share";
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
      };
    };
  };

  services.samba-wsdd = { enable = true; };

  # MacOS TimeMachine
  services.netatalk.settings = {
    TimeMachine = {
      "time machine" = "yes";
      path = "/media/backup/time_machine";
      "valid users" = "@users lor";
    };
  };

  services.avahi = {
    openFirewall = true;
    allowPointToPoint = true;
    reflector = true;
    extraServiceFiles = {
      smb = ''
        <?xml version="1.0" standalone='no'?>
        <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
        <service-group>
          <name replace-wildcards="yes">%h</name>
          <service>
            <type>_smb._tcp</type>
            <port>445</port>
          </service>
          <service>
            <type>_device-info._tcp</type>
            <port>0</port>
            <txt-record>model=MacPro7,1@ECOLOR=226,226,224</txt-record>
          </service>
          <service>
            <type>_adisk._tcp</type>
            <port>9</port>
            <txt-record>sys=waMa=0,adVF=0x100,adVU=b08171b5-7b5c-4a6d-9774-99f7a7d40cdc</txt-record>
            <txt-record>dk0=adVN=TimeMachine,adVF=0x81</txt-record>
          </service>
        </service-group>
      '';
    };
  };
}
