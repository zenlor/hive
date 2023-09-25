{ inputs
, cell
}:
let
  inherit (inputs)
    nixpkgs
    nixpkgs-unstable
    ;
  unstable = import nixpkgs-unstable {
    inherit (nixpkgs) system;
  };
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = [
      nixpkgs.shfmt
      nixpkgs.fzf
    ];

    plugins = with unstable.vimPlugins; [
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

    extraLuaConfig = builtins.readFile ./neovim.d/init.lua;
  };
}
