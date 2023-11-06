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
