{ inputs
, cell
}:
let
  inherit (inputs)
    pkgs
    ;
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = [
      pkgs.shfmt
      pkgs.fzf
    ];

    plugins = with pkgs.vimPlugins; [
      # FIXME: use newer plugins or move to lazy (mainly for mini.nvim)
      nvim-lspconfig

      mini-nvim

      # tpope
      vim-fugitive
      vim-vinegar

      # languages
      vim-nix
      vim-go
      vim-terraform

      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          tree-sitter-nix
          tree-sitter-python
          tree-sitter-clojure
          tree-sitter-zig
          tree-sitter-rust
          tree-sitter-go
          tree-sitter-hcl
        ]
      ))

      # ux
      fzf-vim
      fzfWrapper
      terminus
    ];

    extraLuaConfig = builtins.readFile ./neovim.lua;
  };
}
