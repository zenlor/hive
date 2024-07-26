{ super, ... }:
{ pkgs, ... }: {
  imports = with super; [ cli.bat cli.bottom ];

  home.packages = with pkgs; [ jq ijq lazygit k9s nmap rage htop ];

  home.sessionVariables = {
    GOPATH = "$HOME/lib";
    XDG_BROWSER = "elinks";
  };
}
