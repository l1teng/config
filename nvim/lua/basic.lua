local vim = vim

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- restore cursor pos
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_exec('silent! normal! g`"zv', false)
	end,
})

vim.opt.mouse = ""
vim.opt.encoding = "UTF-8"
vim.opt.fileencoding = "utf-8"
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cmdheight = 1
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
-- indent
vim.opt.autoindent = true
vim.opt.smartindent = true
-- search
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- moptde
vim.opt.showmode = false
-- refresh moptdified files
vim.opt.autoread = true
-- wrap
vim.opt.wrap = true
vim.opt.whichwrap = "b,s,<,>,[,],h,l"
-- nopt backup file
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
-- smaller updatetime
vim.opt.updatetime = 300
-- keybind mapping time
vim.opt.timeoutlen = 200
-- split window show pos
vim.opt.splitbelow = true
vim.opt.splitright = true
-- completion
vim.opt.completeopt = "menu,menuone,noselect,noinsert"
vim.opt.list = false -- do not show tab as ^I
vim.opt.listchars = "space:·"
-- enhance completion
vim.opt.wildmenu = true
-- Dont' pass messages to |ins-completin menu|
vim.opt.shortmess = vim.o.shortmess .. "c"
vim.opt.pumheight = 10
-- always show tabline
vim.opt.showtabline = 2
-- clipboard enhance
vim.opt.clipboard = "unnamedplus"
--
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

vim.api.nvim_create_augroup("PythonSettings", {})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.wo.colorcolumn = "80"
	end,
	group = "PythonSettings",
})

-- ================================================================================
-- Keybind
-- ================================================================================
local map = vim.keymap.set
local opt = function(desc)
	return { desc = desc, noremap = true, silent = true, nowait = true }
end
-- basic
map("n", "<leader>w", ":wa<CR>", opt("[basic] File Save"))
map("n", "<leader><CR>", ":noh<CR>", opt("[basic] No Highlight"))
map("v", "<", "<gv", opt("[basic] Indent >"))
map("v", ">", ">gv", opt("[basic] Indent <"))
-- window
map("n", "<C-w>c", ":close<CR>", opt("[builtin] Window Close"))
map("n", "<C-w>>", ":vertical resize +20<CR>", opt("[builtin] Window Resize +w"))
map("n", "<C-w><", ":vertical resize -20<CR>", opt("[builtin] Window Resize -w"))
map("n", "<C-w>+", ":resize +10<CR>", opt("[builtin] Window Resize +h"))
map("n", "<C-w>-", ":resize -10<CR>", opt("[builtin] Window Resize -h"))
-- tab
map("n", "<C-t>C", ":tabclose<CR>", opt())
map("n", "<C-t>c", ":tabnew<CR>", opt())
map("n", "<C-t>n", ":tabnext<CR>", opt())
map("n", "<C-t>p", ":tabprevious<CR>", opt())

-- ================================================================================
-- plug manager
-- ================================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)
