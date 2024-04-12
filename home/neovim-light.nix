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
      telescope
      telescope-undo
      which-key-nvim
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
      require("mini.fuzzy").setup({})

      require("telescope").setup({
        extensions = { undo = {}, },
      })
      require("telescope").load_extension("undo")

      require("which-key").setup({})

      vim.o.background = "dark"
      vim.cmd.colorscheme = "minischeme"

      vim.o.leader = "<space>"

      vim.keymap.set("bb", "<leader>u", "<cmd>Telescope buffers<cr>")
      vim.keymap.set("bs", "<leader>u", "<cmd>w<cr>")
      vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    '';
  };
}

