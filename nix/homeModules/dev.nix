{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # LSP Servers I usually need
    nixd
    fish-lsp
  ];

  programs.go = {
    enable = true;
    goPath = "lib";
  };
}
