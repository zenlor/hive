local wk_enabled, wk = pcall(require, "which-key")

if not wk_enabled then
  return
end


vim.g.mapleader = " "

-- basics
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- which-key/doom-like menus
wk.register({
  ["<leader>"] = {
    ["<space>"] = { "<cmd>Telescope find_files<cr>" },

    f = {
      name = "files",
      f = { "<cmd>Telescope find_files<cr>", "search file" },
      r = { "<cmd>Telescope oldfiles<cr>", "recents" },
      n = { "<enew>", "New File" },
    },

    b = {
      name = "buffers",
      b = { "<cmd>Telescope buffers<cr>"},
      n = { "<cmd>e #<cr>", "next buffer" },
      c = { function()
              local curbufnr = vim.api.nvim_get_current_buf()
              local buflist = vim.api.nvim_list_bufs()
              for _, bufnr in ipairs(buflist) do
                if vim.bo[bufnr].buflisted and bufnr ~= curbufnr and (vim.fn.getbufvar(bufnr, "bufpersist") ~= 1) then
                  vim.cmd("bd " .. tostring(bufnr))
                end
              end
            end,
            "Clear" },
    },

    -- lazy
    l = {
      name = "Lazy",

      L = { "<cmd>Lazy<cr>", desc = "Open Lazy" },
    },

    w = {
      name = "window",
      h = { "<C-w>h", "Go West" },
      h = { "<C-w>j", "Go South" },
      h = { "<C-w>k", "Go North" },
      h = { "<C-w>l", "Go East" },
      d = { "<C-w>q", "Close" },
    }
  },
})


-- buffer
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>fn", "<cmd>enew <cr>", { desc = "New File" })

-- movement
vim.keymap.set("i", "<C-a>", "<Home>")
vim.keymap.set("i", "<C-e>", "<End>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- terminal
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "jk", [[<C-\><C-n>]])
vim.keymap.set("t", "<C-w>h", "<cmd>wincmd h<cr>")
vim.keymap.set("t", "<C-w>j", "<cmd>wincmd j<cr>")
vim.keymap.set("t", "<C-w>k", "<cmd>wincmd k<cr>")
vim.keymap.set("t", "<C-w>l", "<cmd>wincmd l<cr>")
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]])

-- indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
