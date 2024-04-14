require"project_nvim".setup{
  manual_mode = true,
  detection_methods = {"lsp","pattern"},
  patterns = {".git",".editorconfig","package.json","go.mod"},
  silent_chdir = false,
  scope_chdir = "global",
}
require"which-key".setup{}
require"telescope".setup{}
require"telescope".load_extension"projects"
require"nvim-treesitter".setup{
  ensure_installed = {"c","lua","xml"},
  sync_install = false,
  auto_install = true,
  hilight = {
    enable = true,
    additial_vim_regex_hilighting = false,
  },
  indent = {
    enable = true,
  },
}

--[[
-- mini basic configurations
--]]
require"mini.basics".setup{
  options = {
    basic = true,
    extra_ui = true,
    win_borders = 'single',
  },
  mappings = {
    windows = true,
  },
  autocommands = {
    basic = true,
  },
  silent = false,
}

require"mini.ai".setup{}
require"mini.align".setup{}
require"mini.bracketed".setup{}
require"mini.files".setup{}
require"mini.fuzzy".setup{}
require"mini.jump2d".setup{}
require"mini.pairs".setup{}
require"mini.surround".setup{}
require"mini.move".setup{
  -- defaults (Meta) + hjkl.
  mappings = {},
  options = {
    -- Automatically reindent selection during linewise vertical move
    reindent_linewise = true,
  },
}
require"mini.completion".setup{}

-- mini ui/ux
require"mini.trailspace".setup{}
require"mini.tabline".setup{}
require"mini.hipatterns".setup{}
require"mini.indentscope".setup{}
require"mini.map".setup{}
require"mini.starter".setup{}
require"mini.statusline".setup{}
require'mini.base16'.setup{
  palette = {
    base00 = '#112641',
    base01 = '#3a475e',
    base02 = '#606b81',
    base03 = '#8691a7',
    base04 = '#d5dc81',
    base05 = '#e2e98f',
    base06 = '#eff69c',
    base07 = '#fcffaa',
    base08 = '#ffcfa0',
    base09 = '#cc7e46',
    base0A = '#46a436',
    base0B = '#9ff895',
    base0C = '#ca6ecf',
    base0D = '#42f7ff',
    base0E = '#ffc4ff',
    base0F = '#00a5c5',
  },
  use_cterm = true,
  plugins = {
    default = true,
    ['echasnovski/mini.nvim'] = true,
  },
}

--[[
-- settings
--]]
vim.o.clipboard = "unnamedplus"
vim.o.guifont = "Iosevka:h15:Consolas"

--[[
-- mappings
--]]
vim.g.mapleader = " " -- leader is space
local wk = require("which-key")

local MiniFiles = require("mini.files")
local function minifilesToggle(...)
  if not MiniFiles.close() then
    MiniFiles.open(...)
  end
end
local telescope = require("telescope.builtin")

wk.register({
  ["<leader>"] = {

    ["<space>"] = "ignore?",
    ["/"] = {telescope.live_grep, "grep"},
    ["."] = {},
    [":"] = {telescope.planets, "planets"},
    h = {telescope.help_tags, "help tags"},
    j = {telescope.jumplist, "jumplist"},
    p = {telescope.registers, "yank registers"},
    [","] = {telescope.resume, "repeat telescope"},

    f = {
      name = "+file",
      f = {telescope.find_files, "find files"},
      r = {telescope.oldfiles, "recent files"},
      n = {"<cmd>enew<cr>", "new"},
      e = {minifilesToggle, "explore"},
    },
    b = {
      name = "+buffer",
      b = {telescope.buffers, "buffers"},
      k = {"<cmd>Bwipeout<cr>", "kill"},
      K = {"<cmd>bufdo :Bwipeout<cr>", "kill all"},
      n = {"<cmd>bnext<cr>", "next"},
      p = {"<cmd>bprev<cr>", "prev"},
    },
    s = {
      name = "+search",
      h = {telescope.search_history, "history"},
    },
    c = {
      name = "+code",
      f = {telescope.quickfix, "quickfix"},
      h = {telescope.quickfixhistory, "quickfix history"},
    },
    l = {
      name = "+lsp",
      r = {telescope.lsp_references, "references"},
      s = {telescope.lsp_document_symbols, "symbols"},
    },
    o = {
      name = "+open",
      m = {function() vim.notify("umme!", vim.log.levels.WARN) end, "toggle mini.map"},
      p = {require"telescope".extensions.projects.projects, "find projects"},
    },
    w = {
      name = "+windows",
      h = { "<C-W><C-H>", "focus left" },
      j = { "<C-W><C-J>", "focus above" },
      k = { "<C-W><C-K>", "focus below" },
      l = { "<C-W><C-L>", "focus right" },

      s = {
        name = "+split",
        s = {"<C-W>s", "horizontal"},
        v = {"<C-W>v", "vertical"},

        h = { "<C-W>H", "Move to far left" },
        j = { "<C-W>J", "Move to far bottom" },
        k = { "<C-W>K", "Move to far top" },
        l = { "<C-W>L", "Move to far right" },
      },
    },
  },
})
