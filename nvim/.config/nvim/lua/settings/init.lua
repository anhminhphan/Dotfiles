CONFIG_PATH = vim.fn.stdpath "config"
DATA_PATH = vim.fn.stdpath "data"
CACHE_PATH = vim.fn.stdpath "cache"
TERMINAL = vim.fn.expand "$TERMINAL"
USER = vim.fn.expand "$USER"


local opt = vim.opt

-- Backups
opt.backup = false
opt.writebackup = false

-- Copy Paste
opt.clipboard = "unnamedplus"

-- Command Line Space
opt.cmdheight = 2

-- Autocomplete enable
opt.completeopt = { "menuone", "noselect" }

-- Color Column
opt.colorcolumn = "99999" -- fixes indentline for now

-- Conceal Level
opt.conceallevel = 0 -- so that `` is visible in markdown files

-- File Encoding
opt.fileencoding = "utf-8" -- the encoding written to a file

-- Multiple Buffers and open Multiple Buffers
opt.hidden = true -- required to keep multiple buffers and open multiple buffers

-- Search Options
opt.hlsearch = true-- highlight all matches on previous search pattern
opt.incsearch = true
opt.ignorecase = true -- ignore case in search patterns

-- Mouse
opt.mouse = "a" -- allow the mouse to be used in neovim

-- Terminal colors
opt.termguicolors = true -- set term gui colors (most terminals support this)

-- Popup menu height
opt.pumheight = 10 -- pop up menu height

-- smarter indent
opt.smartindent = true -- make identing smarter again
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation

-- horizontal split always below and veritcal split always to the right
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window

-- Tabs
opt.showtabline = 2 -- always show tabs
opt.expandtab = true -- convert tabs to spaces
opt.tabstop = 2 -- insert 2 spaces for a tab

-- Undo
opt.undodir = CACHE_PATH .. "/undo" -- set an undo directory
opt.undofile = true -- enable persisten undo

-- Swapfile
opt.swapfile = false -- creates a swapfile

-- Time for sequence of keys
opt.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.updatetime = 300 -- faster completion

-- Line numbers and cursorline
opt.cursorline = true -- highlight the current line
opt.number = true -- set numbered lines
opt.relativenumber = true-- set relative numbered lines
opt.numberwidth = 4 -- set number column width to 2 {default 4}
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time

-- Long line appears as one
opt.wrap = false -- display lines as one long line

opt.spelllang = "en"
opt.scrolloff = 8 -- is one of my fav

