{ super, ... }:
{ pkgs, ... }: {
  home.packages = with pkgs; [
    htop
    ijq
    jq
    k9s
    lazygit
    lazysql
    nmap
    rage
    (ripgrep.override { withPCRE2 = true; })
    fd
    zstd
    xh
    pandoc
  ];

  home.sessionVariables = {
    # XDG_BROWSER = "elinks";
  };
}
