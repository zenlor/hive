{ ... }: {
  users = {
    groups = { share = { gid = 10000; }; };

    users = {
      share = {
        uid = 10000;
        isNormalUser = false;
        isSystemUser = true;
        group = "share";
      };
    };
  };
}
