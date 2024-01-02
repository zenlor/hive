{ super, ... }:
{ pkgs, ... }: {
  imports = with super; [ cli.bat cli.bottom ];

  home.packages = with pkgs; [ jq ijq gitui ];

  home.sessionVariables = {
    GOPATH = "$HOME/lib";
    XDG_BROWSER = "elinks";
  };
}
