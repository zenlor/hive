{ ... }:
{ pkgs, lib, ... }: {

  home.packages = with pkgs; [
    # LSP Servers I usually need
    gopls
    superhtml
    nixd
    fish-lsp
    # zig
    zig
    zls
  ];

  programs.go = {
    enable = true;
    goPath = "lib";
  };
}
