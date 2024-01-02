-- ~ banner "Stick Letters"
-- vim: expandtab tabstop=4

--[[

|\/| | |\ | |  |\ | \  / |  |\/|
|  | | | \| | .| \|  \/  |  |  |

--]]
require'mini.align'.setup{}
require'mini.basics'.setup{
  options = {
    basic = true,
    extra_ui = true,
    win_borders = 'single',
  },
}
require'mini.base16'.setup{
  palette = require'mini.base16'.mini_palette('#1d1f21', '#e2e98f', 75),
  use_cterm = true,
  plugins = { default = true },
}
require'mini.bracketed'.setup{}
require'mini.clue'.setup{}
require'mini.comment'.setup{}
require'mini.completion'.setup{
  lsp_completion = {
    auto_setup = true,
  },
  mappings = {
    force_twostep = '<C-Space>',
    force_fallback = '<A-Space>',
  },
  set_vim_settings = true,
}
require'mini.files'.setup{}
require'mini.fuzzy'.setup{}
require'mini.hipatterns'.setup{
  highlighters = {
    fixme = { pattern = 'FIXME', group = 'MiniHipatternsFixme' },
    hack  = { pattern = 'HACK',  group = 'MiniHipatternsHack' },
    todo  = { pattern = 'TODO',  group = 'MiniHipatternsTodo' },
    note  = { pattern = 'NOTE',  group = 'MiniHipatternsNote' },
  }
}
require'mini.pairs'.setup{}
require'mini.statusline'.setup{
  set_vim_settings = true,
}
require'mini.surround'.setup{}
require'mini.tabline'.setup{
  show_icons = true,
}
require'mini.trailspace'.setup{}

--[[
__   __   __   __        ___    __
|    /__` |__) /  ` /  \ |\ | |__  | / _`
|___ .__/ |    \__, \__/ | \| |    | \__>

--]]

-- LSP -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local lspconfig = require'lspconfig'
lspconfig.rust_analyzer.setup{}
lspconfig.nixd.setup{}
lspconfig.gopls.setup{}
lspconfig.tsserver.setup{}

-- LSP Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<Leader>ee', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


--
-- NeoGIT
--
require'neogit'.setup()

--
-- treesitter
--
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  refactor = {
    navigation = {
      enable = true,
      -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
    highlight_current_scope = { enable = false },
    smart_rename = {
      enable = true,
      -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
      keymaps = {
        smart_rename = "grr",
      },
    },
  },
}

--
-- Keymaps
--
vim.g.mapleader = ' ' -- space as <leader>

vim.keymap.set('n', '<leader>.', function() if not MiniFiles.close() then MiniFiles.open() end end)

-- -- Doom-like keybindings
vim.keymap.set('n', '<Leader>bs', '<cmd>w<cr>')
-- -- window movement
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
-- -- fixes
vim.keymap.set('n', '<esc><esc>', '<cmd>nohl<cr>')
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')
-- -- fzf
vim.keymap.set('n', '<Leader><space>', '<cmd>GitFiles<cr>')
vim.keymap.set('n', '<Leader>bb', '<cmd>Buffers<cr>')
vim.keymap.set('n', '<Leader>fr', '<cmd>History<cr>')
-- -- neogit poor-man's magit
vim.keymap.set('n', '<Leader>gg', '<cmd>Neogit<cr>')

--
-- UI Options
--
vim.o.listchars = 'nbsp:☠,tab:│ ,trail:-,extends:>,precedes:<,nbsp:+'

--
-- Settings
--
vim.g.editorconfig = true
vim.o.autochdir = true
vim.o.relativenumber = true
