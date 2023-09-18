{
  programs.ssh = {
    enable = true;
    compression = true;
    serverAliveInterval = 60;
  };

  programs.keychain = {
    enable = true;
  };
}
