{ ... }:
{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [ shfmt fzf neovim-remote ];

    plugins = with pkgs.vimPlugins; [
      # FIXME: use newer plugins or move to lazy (mainly for mini.nvim)
      nvim-lspconfig
      # FIXME archived from the author, switch to nvimtools/none-ls when available
      null-ls-nvim

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

      # language support
      formatter-nvim

      # ux
      fzf-vim
      fzfWrapper
      terminus
    ];

    extraLuaConfig = builtins.readFile ./neovim.d/init.lua;
  };
}
