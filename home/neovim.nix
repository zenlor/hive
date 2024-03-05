{ ... }:
{ pkgs, lib, ... }: {

  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [ lua-language-server stylua ripgrep ];
    plugins = with pkgs.vimPlugins; [ lazy-nvim ];
  };

  xdg.configFile."nvim/init.lua".source = ./neovim.d/init.lua;
  xdg.configFile."nvim/lua".source = ./neovim.d/lua;
}
