-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Setting options ]]
-- Make line numbers default
vim.opt.number = true
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- keymap helper
local function kmap(keys, func, desc)
  vim.keymap.set('n', keys, func, {desc = desc})
end

kmap('<Esc>', '<cmd>nohlsearch<CR>', 'wipe search breadcrumbs')

-- Diagnostic keymaps
kmap('[d',        vim.diagnostic.goto_prev, 'Go to previous [D]iagnostic message')
kmap(']d',        vim.diagnostic.goto_next, 'Go to next [D]iagnostic message')
kmap('<leader>e', vim.diagnostic.open_float, 'Show diagnostic [E]rror messages')
kmap('<leader>q', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
kmap('<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
kmap('<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
kmap('<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
kmap('<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})

do -- [[ MiniDeps ]]
  -- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
  local path_package = vim.fn.stdpath('data') .. '/site/'
  local mini_path = path_package .. 'pack/deps/start/mini.nvim'
  if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
      'git', 'clone', '--filter=blob:none',
      'https://github.com/echasnovski/mini.nvim', mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.nvim | helptags ALL')
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
  end
end
local Deps = require'mini.deps'
Deps.setup { path = { package = path_package } }


do
  Deps.add({
    source = 'echasnovski/mini.nvim',
  })

  require'mini.icons'.setup()
  require'mini.notify'.setup()
  require'mini.statusline'.setup()
  require'mini.cursorword'.setup({ delay = 150, })

  local hipatterns = require('mini.hipatterns')
  hipatterns.setup({
    highlighters = {
      -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
      fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
      hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
      todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
      note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

      -- Highlight hex color strings (`#rrggbb`) using that color
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })

  -- MiniFiles
  local files = require'mini.files'
  files.setup { }
  local minifiles_toggle = function(...)
    if not files.close() then files.open(...) end
  end

  vim.keymap.set('n', '<leader>fe', minifiles_toggle, { desc = 'toggle mini.files' })

  -- MiniCompletion
  require'mini.completion'.setup{
    delay = { completion = 100, info = 100, signature = 50 },
    window = {
      info = { height = 25, width = 80, border = 'none' },
      signature = { height = 25, width = 80, border = 'none' },
    },
    lsp_completion = {
      source_func = 'completefunc', -- completefunc|omnifunc
      auto_setup = true,
    },
    mappings = {
      force_twostep = '<C-Space>', -- Force two-step completion
      force_fallback = '<A-Space>', -- Force fallback completion
    },
    set_vim_settings = true,
  }

  -- MiniClues
  local clue = require('mini.clue')
  clue.setup({
    triggers = {
      -- Leader triggers
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },

      -- Built-in completion
      { mode = 'i', keys = '<C-x>' },

      -- `g` key
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },

      -- Marks
      { mode = 'n', keys = "'" },
      { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },

      -- Registers
      { mode = 'n', keys = '"' },
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },

      -- Window commands
      { mode = 'n', keys = '<C-w>' },

      -- `z` key
      { mode = 'n', keys = 'z' },
      { mode = 'x', keys = 'z' },
    },

    clues = {
      -- Enhance this by adding descriptions for <Leader> mapping groups
      clue.gen_clues.builtin_completion(),
      clue.gen_clues.g(),
      clue.gen_clues.marks(),
      clue.gen_clues.registers(),
      clue.gen_clues.windows(),
      clue.gen_clues.z(),
    },
  })

  -- Better Around/Inside textobjects
  --
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yinq - [Y]ank [I]nside [N]ext [']quote
  --  - ci'  - [C]hange [I]nside [']quote
  require('mini.ai').setup { n_lines = 500 }

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  require('mini.surround').setup()

  -- Simple and easy statusline.
  --  You could remove this setup call if you don't like it,
  --  and try some other statusline plugin
  local statusline = require 'mini.statusline'
  -- You can configure sections in the statusline by overriding their
  -- default behavior. For example, here we set the section for
  -- cursor location to LINE:COLUMN
  statusline.section_location = function()
    return '%2l:%-2v'
  end

  -- mini.notify
  require'mini.notify'.setup()

  -- mini.comment
  require'mini.comment'.setup {
    options = {
      ignore_blank_line = true,
      pad_comment_parts = true,
    },
    mappings = {
      comment = 'gc',
      comment_line = 'gcc',
      comment_visual = 'gc',
      textobject = 'gc',
    },
  }

  -- mini.fuzzy
  require'mini.fuzzy'.setup()

  -- mini.move
  require'mini.move'.setup{
    mappings = {
      left  = '<M-h>',
      right = '<M-l>',
      up    = '<M-k>',
      down  = '<M-j>',

      line_left  = '<M-h>',
      line_right = '<M-l>',
      line_up    = '<M-k>',
      line_down  = '<M-j>',
    },
  }

  require'mini.pairs'.setup()
  require'mini.starter'.setup()
  require'mini.jump'.setup()
  require'mini.jump2d'.setup()
end

do
  Deps.add({ source = "ellisonleao/gruvbox.nvim" })

  vim.cmd.colorscheme 'gruvbox'
  vim.cmd.hi 'Comment gui=none'
end

do
  Deps.add({
    source = "tpope/vim-sleuth"
  })
end

do
  Deps.add({
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "v0.9.2",
    hooks = {
      post_checkout = function()
        vim.cmd('TSUpdate')
      end,
    },
  })

  require('nvim-treesitter.install').prefer_git = true
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  })
end

do -- [[ telescope ]]
  Deps.add{
    source = 'nvim-telescope/telescope.nvim',
    depends = {
    {source = 'nvim-lua/plenary.nvim'},
    },
  }

  require'telescope'.setup{
    defaults = { generic_sorter = require'mini.fuzzy'.get_telescope_sorter, },
    extensions = {
      ['ui-select'] = { require'telescope.themes'.get_dropdown(), },
    },
  }

  pcall(require'telescope'.load_extension, 'fzf')
  pcall(require'telescope'.load_extension, 'ui-select')


  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

  -- Slightly advanced example of overriding default behavior and theme
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  vim.keymap.set('n', '<leader>s/', function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end, { desc = '[S]earch [/] in Open Files' })

  -- Shortcut for searching your Neovim configuration files
  vim.keymap.set('n', '<leader>sn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[S]earch [N]eovim files' })
end

do -- [[ LSP ]]
  Deps.add{ source = 'neovim/nvim-lspconfig' }
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('hive-lsp-attach', { clear = true }),
    callback = function()
      local map = function(keys, func, desc)
        vim.keymap('n', keys, func, {buffer = event.buf, desc = 'LSP: '..desc })
      end

      -- Jump to the definition of the word under your cursor.
      --  This is where a variable was first declared, or where a function is defined, etc.
      --  To jump back, press <C-t>.
      map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

      -- Find references for the word under your cursor.
      map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

      -- Jump to the implementation of the word under your cursor.
      --  Useful when your language has ways of declaring types without an actual implementation.
      map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

      -- Jump to the type of the word under your cursor.
      --  Useful when you're not sure what type a variable is and you want to see
      --  the definition of its *type*, not where it was *defined*.
      map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

      -- Fuzzy find all the symbols in your current document.
      --  Symbols are things like variables, functions, types, etc.
      map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

      -- Fuzzy find all the symbols in your current workspace.
      --  Similar to document symbols, except searches over your entire project.
      map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- Rename the variable under your cursor.
      --  Most Language Servers support renaming across files, etc.
      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      -- Opens a popup that displays documentation about the word under your cursor
      --  See `:help K` for why this keymap.
      map('K', vim.lsp.buf.hover, 'Hover Documentation')

      -- WARN: This is not Goto Definition, this is Goto Declaration.
      --  For example, in C this would take you to the header.
      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client.server_capabilities.documentHighlightProvider then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      -- The following autocommand is used to enable inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, '[T]oggle Inlay [H]ints')
      end

    end
  })
end

do -- [[ AutoFormat ]]
  Deps.add{ source = 'stevearc/conform.nvim' }
  local conform = require'conform'

  kmap('<leader>cf', function()
    conform.format{async = true, lsp_fallback = true}
  end, '[F]ormat buffer')

  conform.setup{
    default_format_opts = {
      lsp_format = 'fallback',
    },
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = {'stylua'},
      nix = {{'nixpkgs_fmt', 'nix_fmt'}},
      go = { 'goimports', 'gofmt' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
      zig = { 'zigfmt', lsp_format = 'fallback' },
      tf = { {'terraform_fmt', 'tofu_fmt'}, lsp_format = 'fallback'},
      hcl = { 'hcl' },
    },
  }
end

-- [[ Doom-like Keymaps ]]
do
  local none = function() end
  local tsb = require'telescope.builtin'
  local mbf = require'mini.bufremove'

  kmap('<leader>b',  none, '[B]uffers') -- dummy
  kmap('<leader>bb', tsb.buffers, '[B]uffer list' )
  kmap('<leader>bk', mbf.delete, '[K]ill buffer' )
  kmap('<leader>bw', mbf.wipeout, '[W]ipeout buffer')
  kmap('<leader>b/', tsb.current_buffer_fuzzy_find, '[/] find in buffer')
  kmap('<leader>bt', tsb.current_buffer_tags, '[/] find in buffer')
  kmap('<leader>bs', ':w', '[S]ave')
  kmap('<leader>,',  tsb.resume, 'resume ...')

  kmap('<leader><space>', tsb.find_files, 'find in project')
  kmap('<leader>ff', tsb.find_files, '[F]ind in project')
  kmap('<leader>fg', tsb.live_grep, '[G]rep project')

end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
