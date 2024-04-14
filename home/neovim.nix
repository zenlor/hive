{ ... }:
{ pkgs, lib, ... }: {

  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      neovim-remote

      # Telescope
      ripgrep
    ];

    plugins = with pkgs.vimPlugins; [
      mini-nvim
      which-key-nvim
      telescope-nvim
      project-nvim
      nvim-treesitter
    ];
  };

  # xdg.configFile."nvim/after".source = ./neovim.d/after;
  # xdg.configFile."nvim/lua".source = ./neovim.d/lua;
  xdg.configFile."nvim/init.lua".source = ./neovim.d/init.lua;
}
