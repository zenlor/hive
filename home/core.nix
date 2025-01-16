{ super, ... }:
{ pkgs, ... }: {
  home.packages = with pkgs; [ jq ijq lazygit gitui k9s kdash nmap rage htop ];

  home.sessionVariables = {
    GOPATH = "$HOME/lib";
    XDG_BROWSER = "elinks";
    EDITOR = "nvim";
  };
}
