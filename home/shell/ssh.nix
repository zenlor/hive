{
  programs.ssh = {
    enable = true;
    compression = true;
    serverAliveInterval = 60;
    includes = [ "local" ];
  };

  programs.keychain = { enable = true; };
}
