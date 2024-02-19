{ ... }:
{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [ shfmt fzf neovim-remote ];

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig

      # format on save
      plenary-nvim
      none-ls-nvim

      # treesitter
      nvim-treesitter-textobjects
      nvim-treesitter-textsubjects
      nvim-treesitter-refactor

      nvim-treesitter.withAllGrammars
      #
      # (with nvim-treesitter-parsers; [
      #   fennel
      #   fish
      #   gitcommit git_rebase git_config
      #   go
      #   html
      #   ini
      #   javascript
      #   json
      #   lua
      #   nix
      #   org
      #   python
      #   sql
      #   toml
      #   ungrammar
      #   vim
      #   xml
      #   yaml
      #   zig
      # ])

      neogit
      mini-nvim

      # languages
      vim-nix

      # ux
      fzf-vim
      fzfWrapper
      terminus
    ];

    extraLuaConfig = builtins.readFile ./neovim.d/init.lua;
  };
}
