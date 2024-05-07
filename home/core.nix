{ super, ... }:
{ pkgs, ... }: {
  imports = with super; [ cli.bat cli.bottom ];

  home.packages = with pkgs; [ jq ijq gitui lazygit k9s neofetch rage ];

  home.sessionVariables = {
    GOPATH = "$HOME/lib";
    XDG_BROWSER = "elinks";
  };
}
