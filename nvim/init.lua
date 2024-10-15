local vim = vim
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

-- ================================================================================
-- Basic
-- ================================================================================
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
vim.opt.timeoutlen = 500
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

vim.api.nvim_create_augroup('PythonSettings', {})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.wo.colorcolumn = "80"
  end,
  group = 'PythonSettings',
})


-- ================================================================================
-- plugs
-- ================================================================================
-- lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local conf = require("conf")
conf.auto_restore_cursor_pos()
local keyb = require("keybind")
for _, k in ipairs({ "basic", "window", "tab" }) do
	keyb[k]()
end
require("lazy").setup({
	spec = {
		{
			"marko-cerovac/material.nvim",
			commit = "ac8f02e",
			dependencies = {
				{
					"rcarriga/nvim-notify",
					tag = "v3.13.5",
					config = function()
						vim.notify = require("notify")
					end,
				},
				{
					"j-hui/fidget.nvim",
					tag = "v1.4.5",
					opts = {},
				},
				{
					"nvim-tree/nvim-tree.lua",
					commit = "cb57691",
					lazy = true,
					init = function()
						vim.g.loaded_netrw = 1
						vim.g.loaded_netrwPlugin = 1
						vim.o.termguicolors = true
						vim.opt.termguicolors = true
					end,
					opts = conf.nvt(keyb.nvt_buf),
					keys = keyb.nvt,
				},
				{
					"lukas-reineke/indent-blankline.nvim",
					tag = "v3.7.2",
					config = function()
						conf.ibl_hook()
						require("ibl").setup(conf.ibl)
					end,
				},
				{
					"akinsho/bufferline.nvim",
					tag = "v4.7.0",
					dependencies = {
						{
							"famiu/bufdelete.nvim",
							commit = "f6bcea7",
							keys = keyb.bufdelete,
						},
					},
					init = function()
						vim.o.termguicolors = true
						vim.opt.termguicolors = true
					end,
					opts = conf.bufferline,
					keys = keyb.bufferline,
				},
				{
					"nvim-lualine/lualine.nvim",
					commit = "b431d22",
					opts = conf.lualine,
				},
				{
					"lewis6991/gitsigns.nvim",
					commit = "1ef74b5",
					opts = {},
					keys = keyb.gitsigns,
				},
				{
					"folke/which-key.nvim",
					tag = "v3.13.2",
					lazy = true,
					opts = {},
				},
				{
					"phaazon/hop.nvim",
					tag = "v2.0.3",
					lazy = true,
					opts = { keys = "etovxqpdygfblzhckisuran" },
					keys = keyb.hop,
				},
				{
					"ThePrimeagen/harpoon",
					commit = "0378a6c",
					lazy = true,
					opts = {},
					keys = keyb.harpoon,
					dependencies = {
						{
							"nvim-telescope/telescope.nvim",
							commit = "df534c3",
							lazy = true,
							dependencies = { { "nvim-lua/plenary.nvim", tag = "v0.1.4" } },
							opts = conf.telescope,
							keys = keyb.telescope,
						},
					},
				},
				{ "RRethy/vim-illuminate", commit = "5eeb795" },
				{
					"hrsh7th/nvim-cmp",
					commit = "ae644fe",
					dependencies = {
						{ "onsails/lspkind.nvim", commit = "cff4ae3", lazy = true },
						{ "hrsh7th/cmp-buffer", commit = "3022dbc", lazy = true },
						{ "hrsh7th/cmp-path", commit = "91ff86c", lazy = true },
						{
							"hrsh7th/cmp-vsnip",
							commit = "989a8a7",
							lazy = true,
							dependencies = {
								{
									"hrsh7th/vim-vsnip",
									commit = "02a8e79",
									lazy = true,
									dependencies = {
										{ "rafamadriz/friendly-snippets", branch = "main" },
									},
								},
							},
						},
						{
							"hrsh7th/cmp-nvim-lsp",
							commit = "39e2eda",
							lazy = true,
							dependencies = {
								{
									"neovim/nvim-lspconfig",
									tag = "v0.1.8",
									lazy = true,
								},
							},
							config = function()
								conf.lsp_config()
							end,
						},
						{
							"zbirenbaum/copilot-cmp",
							commit = "b6e5286",
							lazy = true,
							dependencies = {
								{
									"zbirenbaum/copilot.lua",
									commit = "86537b2",
									lazy = true,
									opts = conf.copilot,
								},
							},
							opts = {},
						},
					},
					config = function()
						conf.cmp(keyb.cmp())
					end,
				},
			},
			init = function()
				vim.g.material_style = "darker"
				vim.cmd([[colorscheme material]])
			end,
			opts = conf.material,
		},
		{
			"numToStr/Comment.nvim",
			tag = "v0.8.0",
			lazy = true,
			opts = { mappings = { extra = false } },
		},
		{
			"windwp/nvim-autopairs",
			commit = "fd2badc",
			opts = {},
		},
		{ "aserowy/tmux.nvim", commit = "65ee9d6" },
		{
			"stevearc/conform.nvim",
			branch = "nvim-0.9",
			lazy = true,
			opts = conf.conform,
			keys = keyb.conform,
		},
		{ "mfussenegger/nvim-lint", branch = "master", config = conf.nvim_lint },
		{
			"ray-x/lsp_signature.nvim",
			tag = "v0.3.1",
			opts = {},
		},
		{
			"nvimdev/lspsaga.nvim",
			commit = "4ce44df",
			lazy = true,
			dependencies = {
				{
					"nvim-treesitter/nvim-treesitter",
					tag = "v0.9.2",
					lazy = true,
					main = "nvim-treesitter.configs",
					opts = conf.nvim_treesitter,
				},
				{ "nvim-tree/nvim-web-devicons", tag = "v0.100", lazy = true },
			},
			opts = {},
			keys = keyb.lspsaga,
		},
		{
			"lervag/vimtex",
			tag = "v2.15",
			ft = { "tex", "plaintex", "bib" },
			init = function()
				vim.g.vimtex_view_method = (jit.os:lower() == "osx") and "skim" or ""
				vim.g.vimtex_quickfix_open_on_warning = 0
			end,
		},
		{
			"williamboman/mason.nvim",
			tag = "v1.10.0",
			dependencies = {
				{
					"WhoIsSethDaniel/mason-tool-installer.nvim",
					commit = "c5e07b8",
					config = function()
						require("mason-tool-installer").setup(conf.mason_tool_installer)
					end,
				},
			},
			opts = {},
		},
	},
	checker = { enabled = true },
})
