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
    extraPackages = with unstable;[
      shfmt
      fzf
      neovim-remote
    ];

    plugins = with unstable.vimPlugins; [
      # FIXME: use newer plugins or move to lazy (mainly for mini.nvim)
      nvim-lspconfig

      mini-nvim

      # tpope
      vim-vinegar

      # git
      neogit

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
          tree-sitter-lua
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
