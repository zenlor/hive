{ super, ... }:
{ pkgs, ... }: {
  home.packages = with pkgs; [
    jq
    ijq
    lazygit
    lazysql
    k9s
    nmap
    rage
    htop
  ];

  home.sessionVariables = {
    XDG_BROWSER = "elinks";
    EDITOR = "nvim";
  };
}
