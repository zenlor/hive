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

    # C# for RimRim
    omnisharp-roslyn
  ];

  programs.go = {
    enable = true;
    goPath = "lib";
  };
}
