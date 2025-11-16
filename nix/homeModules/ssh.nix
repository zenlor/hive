{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false; # NOTE: default config removed in 25.11

    includes = [ "local" ];

    matchBlocks = {
      "*" = {
        compression = true;
        serverAliveInterval = 60;
      };
      "frenz.click" = {
        hostname = "frenz.click";
        user = "lor";
      };
      "nas.out" = {
        hostname = "10.69.0.2";
        proxyJump = "frenz.click";
        user = "lor";
      };
    };
  };

  programs.keychain = {
    enable = true;
    keys = [
      "id_ecdsa"
      "id_ed25519"
      "id_rsa"
    ];
  };
}
