{ super, ... }:
{ pkgs, ... }: {
  home.packages = with pkgs; [ jq ijq lazygit k9s nmap rage htop ];

  home.sessionVariables = {
    GOPATH = "$HOME/lib";
    XDG_BROWSER = "elinks";
    EDITOR = "nvim";
  };
}
