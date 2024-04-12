return {
  { "catppuccin/nvim",
    name = "catppuccin",
  },

  { "nvim-lualine/lualine.nvim",
    config = true,
  },

  { "akinsho/bufferline.nvim",
    config = true,
  },

  { "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
  },

  { "echasnovski/mini.indentscope",
  },

  { "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },

  { "folke/todo-comments.nvim",
    config = true,
  },

  { "stevearc/dressing.nvim",
  },

  { "rcarriga/nvim-notify",
  },

  { "nvimdev/dashboard-nvim",
  },
}
