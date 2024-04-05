-- Search character cases
vim.o.ignorecase = true
vim.o.smartcase = true

-- Indentation
vim.o.tabstop = 8
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.breakindent = true

-- Timings
vim.o.updatetime = 250
vim.o.timoutlen = 300

-- Left column
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'

-- Undo and copy/paste
vim.o.undofile = true
vim.o.clipboard = 'unnamedplus'

-- Mouse
vim.o.completeopt = 'menuone,noselect'
vim.o.mouse = ''
vim.o.hlsearch = false

-- Movement
vim.opt.scrolloff = 999
vim.o.textwidth = 80

-- Netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- TUI
vim.o.termguicolors = true
vim.o.colorcolumn = "80,120"

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
