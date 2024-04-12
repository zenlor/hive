{ ... }:
{ pkgs, lib, ... }: {

  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      shfmt
      fzf
      neovim-remote
      # vim plugins
      lua-language-server
      stylua
      codespell
      selene
      # Telescope
      ripgrep
      # treesitter
      clang # heavy compiler
      gnumake # GNU make
      nodejs_21 # node.js, still required by some stupid lsp server
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
      fzfWrapper
    ];
  };

  xdg.configFile."nvim/after".source = ./neovim.d/after;
  xdg.configFile."nvim/lua".source = ./neovim.d/lua;
  xdg.configFile."nvim/init.lua".source = ./neovim.d/init.lua;
}
