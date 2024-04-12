{ ... }:
{ pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      shfmt
      fzf
      neovim-remote
    ];

    plugins = with pkgs.vimPlugins; [
      mini-nvim
    ];

    extraLuaConfig = ''
      require("mini.basics").setup({
        options = {
          extra_ui = true,
        },
        mappings = {
          basic = true,
          windows = true,
        },

      })
      require("mini.indentscope").setup({})
      require("mini.statusline").setup({})
      require("mini.starter").setup({
        header = " /\\_/\\\n( o.o )\ > ^ <",
        footer = "~~ % ~~",
      })

      vim.o.colorscheme = "minischeme"
    '';
  };

  xdg.configFile."nvim/after".source = ./neovim.d/after;
  xdg.configFile."nvim/lua".source = ./neovim.d/lua;
  xdg.configFile."nvim/init.lua".source = ./neovim.d/init.lua;
}

