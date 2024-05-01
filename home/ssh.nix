{
  programs.ssh = {
    enable = true;
    compression = true;
    serverAliveInterval = 60;
    includes = [ "local" ];
  };

  programs.keychain = {
    enable = true;
    keys = [ "id_ecdsa" "id_ed25519" "id_rsa" ];
  };
}
