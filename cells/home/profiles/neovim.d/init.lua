-- ~ banner "Stick Letters"
-- vim: expandtab tabstop=4


--[[
    ___  __   ___  ___  __    ___ ___  ___  __
     |  |__) |__  |__  /__` |  |   |  |__  |__)
     |  |  \ |___ |___ .__/ |  |   |  |___ |  \

--]]
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highliting = false,
    }
}

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
    palette = require'mini.base16'.mini_palette('#112641', '#e2e98f', 75),
    use_cterm = true,
    plugins = { default = true },
}
require'mini.bracketed'.setup{}
require'mini.comment'.setup{}
require'mini.completion'.setup{}
require'mini.cursorword'.setup{}
require'mini.fuzzy'.setup{}
-- require'mini.hipatterns'.setup({
--     highlighters = {
--         fixme = { pattern = 'FIXME', group = 'MiniHipatternsFixme' },
--         hack  = { pattern = 'HACK',  group = 'MiniHipatternsHack'  },
--         todo  = { pattern = 'TODO',  group = 'MiniHipatternsTodo'  },
--         note  = { pattern = 'NOTE',  group = 'MiniHipatternsNote'  },
--     }
-- })
require'mini.pairs'.setup{}
require'mini.statusline'.setup{
    set_vim_settings = true,
}
require'mini.surround'.setup{}
require'mini.tabline'.setup{
    show_icons = true,
}
require'mini.trailspace'.setup{}

-- require'mini.files'.setup{}
-- vim.keymap.set('n', '-', function() MiniFiles.open() end)

--[[
          __   __   __   __        ___    __
    |    /__` |__) /  ` /  \ |\ | |__  | / _`
    |___ .__/ |    \__, \__/ | \| |    | \__>

--]]

-- LSP -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local lspconfig = require'lspconfig'
lspconfig.gopls.setup{}
lspconfig.tsserver.setup{}

-- LSP Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<Leader>ee', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<Leader>gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<Leader>K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<Leader>gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<Leader><space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<Leader><space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<Leader><space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<Leader><space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<Leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


--[[
          ___                 __
    |__/ |__  \ /  |\/|  /\  |__)
    |  \ |___  |   |  | /~~\ |

--]]

-- Doom-like keybindings
vim.keymap.set('n', '<Leader>bs', '<cmd>w<cr>')
-- window movement
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
-- fixes
vim.keymap.set('n', '<esc><esc>', '<cmd>nohl<cr>')
vim.keymap.set('n', 'Y', 'y$')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')
-- fzf
vim.keymap.set('n', '<Leader><space>', '<cmd>Files<cr>')
vim.keymap.set('n', '<Leader>bb', '<cmd>Buffers<cr>')
vim.keymap.set('n', '<Leader>fr', '<cmd>History<cr>')

--[[
    |  | \_/
    \__/ / \

--]]
vim.o.listchars = 'nbsp:☠,tab:│ ,trail:-,extends:>,precedes:<,nbsp:+'
