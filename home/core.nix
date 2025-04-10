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
    ripgrep
    fd
    xh
  ];

  home.sessionVariables = {
    XDG_BROWSER = "elinks";
    EDITOR = "nvim";
  };
}
