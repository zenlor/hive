do
  -- Put this at the top of 'init.lua'
  local path_package = vim.fn.stdpath('data') .. '/site'
  local mini_path = path_package .. '/pack/deps/start/mini.nvim'
  if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
      'git', 'clone', '--filter=blob:none',
      -- Uncomment next line to use 'stable' branch
      -- '--branch', 'stable',
      'https://github.com/echasnovski/mini.nvim', mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.nvim | helptags ALL')
  end
end

local miniDeps = require("mini.deps")
miniDeps.setup({
  path = { package = path_package }
})
local function InstallDependencies(packages)
  for _,package in ipairs(packages) do
    miniDeps.add(package)
  end
end
InstallDependencies({
  "neovim/nvim-lspconfig",
  "nvim-lua/plenary.nvim",
  "folke/which-key.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-treesitter/nvim-treesitter",
  "ahmedkhalf/project.nvim",
  "f-person/auto-dark-mode.nvim",
})

--[[ LSP ]]--
do
  lspconfig = require("lspconfig")

  lspconfig.lemminx.setup{}
  lspconfig.gopls.setup{}
  lspconfig.zls.setup{}
  lspconfig.nixd.setup{}
end

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
require"mini.bufremove".setup{}
require"mini.cursorword".setup{}
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
require"mini.notify".setup{}
require"mini.starter".setup{}
require"mini.statusline".setup{}

local palette_light = { -- https://github.com/RRethy/base16-nvim/blob/master/lua/colors/ayu-light.lua
    base00 = '#fafafa', base01 = '#f3f4f5', base02 = '#f8f9fa', base03 = '#abb0b6',
    base04 = '#828c99', base05 = '#5c6773', base06 = '#242936', base07 = '#1a1f29',
    base08 = '#f07178', base09 = '#fa8d3e', base0A = '#f2ae49', base0B = '#86b300',
    base0C = '#4cbf99', base0D = '#36a3d9', base0E = '#a37acc', base0F = '#e6ba7e'
}
local palette_dark = { -- https://github.com/RRethy/base16-nvim/blob/master/lua/colors/ayu-dark.lua
  base00 = '#0f1419', base01 = '#131721', base02 = '#272d38', base03 = '#3e4b59',
  base04 = '#bfbdb6', base05 = '#e6e1cf', base06 = '#e6e1cf', base07 = '#f3f4f5',
  base08 = '#f07178', base09 = '#ff8f40', base0A = '#ffb454', base0B = '#b8cc52',
  base0C = '#95e6cb', base0D = '#59c2ff', base0E = '#d2a6ff', base0F = '#e6b673'
}
require"auto-dark-mode".setup({
  update_interval = 1000,
  set_dark_mode = function()
    vim.api.nvim_set_option('background', 'dark')

    require('mini.base16').setup{
      palette = palette_dark,
      use_cterm = true,
      plugins = {
        default = true,
        ['echasnovski/mini.nvim'] = true,
      },
    }
  end,
  set_light_mode = function()
    vim.api.nvim_set_option('background', 'light')

    require('mini.base16').setup{
      palette = palette_light,
      use_cterm = true,
      plugins = {
        default = true,
        ['echasnovski/mini.nvim'] = true,
      },
    }
  end,
})

--[[
-- nnn as file explorer
--
-- https://github.com/bobrown101/minimal-nnn.nvim/tree/main
--]]
function nnn()

    -- start a socket that we can listen for the result on
    local socketname = vim.fn.tempname()
    vim.fn.serverstart(socketname)

    -- generate the nnn command with the right parameters
    local currentLocation = vim.fn.expand('%:p:h')
    local filepickercommand = 'nnn -p - ' .. currentLocation

    -- use nvim --server to "callback" over rpc the result of "filepickercommand"
    local callbackcommand = string.format([[nvim --server %s --remote $(%s) ]],
                                          socketname, filepickercommand)

    -- open up the callbackcommand (which already contains the filepickercommand) in a new terminal buffer
    vim.cmd('term ' .. callbackcommand)
    -- when entering the terminal, automatically enter in insert mode
    vim.cmd('startinsert')

    -- lets grab the buffer number of the terminal buffer we just made
    local termbuffnumber = vim.api.nvim_get_current_buf()

    -- upon closing the terminal (aka, when nnn and the callback process exits), delete the buffer
    vim.api.nvim_create_autocmd({"TermClose"}, {
        buffer = termbuffnumber,
        command = "bd " .. termbuffnumber
    })
end

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
    local current_dir = vim.fn.expand("%:p:h", true)
    MiniFiles.open(current_dir)
  end
end
local telescope = require("telescope.builtin")
local bufremove = require("mini.bufremove")

local function bufwipeoutAll()
  for _, n in ipairs(vim.api.nvim_list_bufs()) do
    bufremove.wipeout(n)
  end

  MiniStarter.open()
end

wk.register({
  ["<esc><esc>"] = {"<cmd>nohl<cr>", "remove search hilight"},

  ["<leader>"] = {

    ["<space>"] = {telescope.find_files, "find files"},
    ["/"] = {telescope.live_grep, "grep"},
    ["."] = {MinifilesToggle, "file explorer"},
    [":"] = {telescope.planets, "planets"},
    [","] = {telescope.resume, "repeat telescope"},
    h = {telescope.help_tags, "help tags"},
    j = {telescope.jumplist, "jumplist"},
    p = {telescope.registers, "yank registers"},

    f = {
      name = "+file",
      f = {telescope.find_files, "find files"},
      r = {telescope.oldfiles, "recent files"},
      n = {"<cmd>enew<cr>", "new"},
      e = {minifilesToggle, "explore"},
      w = {nnn, "open nnn"},
    },
    b = {
      name = "+buffer",
      b = {telescope.buffers, "buffers"},
      k = {bufremove.wipeout, "kill"},
      K = {bufwipeoutAll, "kill all"},
      n = {"<cmd>bnext<cr>", "next"},
      p = {"<cmd>bprev<cr>", "prev"},
      s = {"<cmd>w<cr>", "write"},
      S = {"<cmd>bufdo :w<cr>", "write"},
    },
    s = {
      name = "+search",
      h = {telescope.search_history, "history"},
    },
    c = {
      name = "+code",
      q = {telescope.quickfix, "quickfix"},
      h = {telescope.quickfixhistory, "quickfix history"},
    },
    l = {
      name = "+lsp",
      f = {vim.lsp.buf.format, "format"},
      r = {vim.lsp.buf.rename, "rename"},

      e = {telescope.lsp_references, "references"},
      s = {telescope.lsp_document_symbols, "symbols"},
    },
    o = {
      name = "+open",
      m = {function() vim.notify("FixME!", vim.log.levels.WARN) end, "toggle mini.map"},
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
