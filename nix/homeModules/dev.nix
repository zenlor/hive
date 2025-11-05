{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # LSP Servers I usually need
    nixd
    fish-lsp

    # more general purpose programming languages
    odin
    zig

    # terraria/rimrim?
    dotnet-sdk
  ];

  programs.go = {
    enable = true;
    goPath = "lib";
  };
}
