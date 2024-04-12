require("catppuccin").setup({
  flavour = "mocha",
  integrations = {
    cmp = true,
    dashboard = true,
    fidget = true,
    flash = true,
    gitsigns = true,
    illuminate = true,
    lsp_trouble = true,
    mason = true,
    mini = { enabled = true, indentscope_color = "" },
    neotree = true,
    notify = true,
    telescope = { enabled = true, style = "nvchad" },
    treesitter = true,
    treesitter_context = true,
    which_key = true,
  },
})

vim.cmd.colorscheme("catppuccin")
