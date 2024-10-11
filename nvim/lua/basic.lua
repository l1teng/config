local vim = vim

vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"

vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- show relative column number
vim.wo.number = true
vim.wo.relativenumber = true

-- highlight the focus line
vim.wo.cursorline = true

-- show sign line on the left
vim.wo.signcolumn = "yes"

-- width line
vim.wo.colorcolumn = "80"

-- tab size
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftround = true

-- >> << indent size
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2

-- tab = n*<space>
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true

-- search case sensitive
vim.o.ignorecase = true
vim.o.smartcase = true

-- highlight when searching
vim.o.hlsearch = true

-- search as typing
vim.o.incsearch = true

-- no mode hint
vim.o.showmode = false

-- cmdline height
vim.o.cmdheight = 1

-- autoreload file as modified
vim.o.autoread = true
vim.bo.autoread = true

-- wrap line
vim.o.wrap = true
vim.wo.wrap = true

-- jump to the next line
vim.o.whichwrap = "b,s,<,>,[,],h,l"

-- hide modified buffer
vim.o.hidden = true

-- no mouse support
-- vim.o.mouse = "a"

-- no backup file
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- smaller updatetime
vim.o.updatetime = 300

-- keybind mapping time
vim.o.timeoutlen = 500

-- split window show pos
vim.o.splitbelow = true
vim.o.splitright = true

-- completion
vim.g.completeopt = "menu,menuone,noselect,noinsert"

vim.o.list = false -- do not show tab as ^I
vim.o.listchars = "space:·"

-- enhance completion
vim.o.wildmenu = true

-- Dont' pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.pumheight = 10

-- always show tabline
vim.o.showtabline = 2

-- clipboard enhance
vim.opt.clipboard = "unnamedplus"

--
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")
