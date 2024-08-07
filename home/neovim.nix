{ ... }:
{ pkgs, lib, ... }: {

  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      neovim-remote
      nnn

      # lsp
      ast-grep
      # Telescope
      ripgrep

      # luv
      luajitPackages.luv
    ];
  };

  # xdg.configFile."nvim/after".source = ./neovim.d/after;
  xdg.configFile."nvim/lua".source = ./neovim.d/lua;
  xdg.configFile."nvim/init.lua".source = ./neovim.d/init.lua;
}
