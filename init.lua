-- Package manager
require("paq")({
    "savq/paq-nvim",
    "stevearc/conform.nvim",
    "neovim/nvim-lspconfig",
    "junegunn/fzf",
    "junegunn/fzf.vim",
    "tpope/vim-surround",
    "tpope/vim-fugitive",
    "folke/which-key.nvim",
    "mbbill/undotree",  -- remember undo history
    "lervag/vimtex",    -- latex, including forward/backward search
    "wsdjeg/vim-fetch", -- open files at line, like vim hei:2
    "nvim-treesitter/nvim-treesitter",
    "OXY2DEV/markview.nvim",
})

-- Import python specifics from ~/.config/nvim/lua/
require('python-specific')
require('latex-specific')
require('markdown-specific')

require('lsp-keymaps')

vim.cmd [[colorscheme vim]]
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4
vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.softtabstop = 8
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.scrolloff = 8
vim.opt.wrap = false
vim.opt.mouse = "" -- disable trackpad/mouse scrolling

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.undofile = true
vim.opt.splitright = true -- files will open at right instead of left
vim.opt.splitbelow = true -- files will open at bottom instead of top

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>f", ":Files!<cr>")
vim.keymap.set("n", "<leader>g", ":RG!<cr>")
vim.keymap.set("n", "gb", ":ls<CR>:b<Space>", { noremap = true }) -- jump to buffer using [number] + enter
vim.keymap.set("", "<up>", "<nop>", { noremap = true })    -- disable trackpad scrolling and arrow keys
vim.keymap.set("", "<down>", "<nop>", { noremap = true })  -- disable trackpad scrolling and arrow keys  
vim.keymap.set("i", "<up>", "<nop>", { noremap = true })   -- disable trackpad scrolling and arrow keys  
vim.keymap.set("i", "<down>", "<nop>", { noremap = true }) -- disable trackpad scrolling and arrow keys
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- center cursor after moving down half-page
vim.keymap.set("n", "-", "g;") -- use "-" to jump to previous cursor pos
vim.keymap.set("n", "_", "g,") -- use "shift + -" to jump to forward cursor pos


local lsps = { "pyright", "ruff" }
for _, lsp in pairs(lsps) do
    vim.lsp.enable(lsp)
end

vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = '●',
    -- Only show on current line if you want
    -- source = "if_many",
  },
  virtual_lines = false, -- Disable virtual lines
})


require("conform").setup({
    formatters_by_ft = {
        python = { "ruff_organize_imports", "ruff_format" },
        c = { "clang_format" },
        cpp = { "clang_format" },
    },
    format_after_save = {},
})

-- Remember cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Flash yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Move lines up/down in Visual mode. toggle using 'J' and 'K'
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Indent and stay in visual mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
