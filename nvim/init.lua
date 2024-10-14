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

-- lazy
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- basic
require("basic")

-- ================================================================================
-- plugs
-- ================================================================================
local conf = require("conf")
conf.auto_restore_cursor_pos()
local keyb = require("keybind")
for _, k in ipairs({ "basic", "window", "tab", "lsp" }) do
	keyb[k]()
end
require("lazy").setup({
	spec = {
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
			config = function()
				require("mason").setup(conf.mason)
			end,
		},
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
					"nvim-tree/nvim-tree.lua",
					commit = "cb57691",
					-- dependencies = { { "nvim-tree/nvim-web-devicons", tag = "v0.100" } },
					init = function()
						vim.g.loaded_netrw = 1
						vim.g.loaded_netrwPlugin = 1
					end,
					config = function()
						require("nvim-tree").setup(conf.nvt(keyb.nvt_buf))
						keyb.nvt()
					end,
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
							config = function()
								keyb.bufdelete()
							end,
						},
					},
					init = function()
						vim.o.termguicolors = true
						vim.opt.termguicolors = true
					end,
					config = function()
						conf.bufferline()
						keyb.bufferline()
					end,
				},
				{
					"nvim-lualine/lualine.nvim",
					commit = "b431d22",
					config = function()
						require("lualine").setup(conf.lualine)
					end,
				},
				{
					"lewis6991/gitsigns.nvim",
					commit = "1ef74b5",
					config = function()
						require("gitsigns").setup()
					end,
				},
				{
					"j-hui/fidget.nvim",
					tag = "v1.4.5",
					config = function()
						require("fidget").setup()
					end,
				},
				{
					"folke/which-key.nvim",
					tag = "v3.13.2",
					config = function()
						require("which-key").setup()
					end,
				},
				{
					"phaazon/hop.nvim",
					tag = "v2.0.3",
					config = function()
						require("hop").setup(conf.hop)
						keyb.hop()
					end,
				},
				{
					"hrsh7th/nvim-cmp",
					commit = "ae644fe",
					dependencies = {
						{ "onsails/lspkind.nvim", commit = "cff4ae3" },
						{ "hrsh7th/cmp-buffer", commit = "3022dbc" },
						{ "hrsh7th/cmp-path", commit = "91ff86c" },
						{
							"hrsh7th/cmp-vsnip",
							commit = "989a8a7",
							dependencies = {
								{
									"hrsh7th/vim-vsnip",
									commit = "02a8e79",
									dependencies = {
										{ "rafamadriz/friendly-snippets", branch = "main" },
									},
								},
							},
						},
						{
							"hrsh7th/cmp-nvim-lsp",
							commit = "39e2eda",
							dependencies = {
								{
									"neovim/nvim-lspconfig",
									tag = "v0.1.8",
									config = function() end,
								},
							},
							config = function()
								conf.lsp_config()
							end,
						},
						{
							"zbirenbaum/copilot-cmp",
							commit = "b6e5286",
							dependencies = {
								{
									"zbirenbaum/copilot.lua",
									commit = "86537b2",
									config = function()
										require("copilot").setup(conf.copilot)
									end,
								},
							},
							config = function()
								require("copilot_cmp").setup()
							end,
						},
					},
					config = function()
						-- require("cmp").setup(conf.cmp(keyb.cmp()))
						conf.cmp(keyb.cmp())
					end,
				},
			},
			init = function()
				vim.g.material_style = "darker"
			end,
			config = function()
				require("material").setup(conf.material)
				vim.cmd([[colorscheme material]])
				keyb.material()
			end,
		},
		{
			"numToStr/Comment.nvim",
			tag = "v0.8.0",
			config = function()
				require("Comment").setup(conf.comment)
			end,
		},
		{
			"windwp/nvim-autopairs",
			commit = "fd2badc",
			config = function()
				require("nvim-autopairs").setup()
			end,
		},
		{ "aserowy/tmux.nvim", commit = "65ee9d6" },
		{
			"nvim-telescope/telescope.nvim",
			-- tag = "0.1.8",
			commit = "df534c3",
			dependencies = { { "nvim-lua/plenary.nvim", tag = "v0.1.4" } },
			config = function()
				require("telescope").setup()
				keyb.telescope()
			end,
		},
		{
			"stevearc/conform.nvim",
			branch = "nvim-0.9",
			config = function()
				local conform = require("conform")
				-- conform.setup(conf.conform)
				conf.conform(conform)
				keyb.conform(conform)
			end,
		},
		{ "mfussenegger/nvim-lint", branch = "master", config = conf.nvim_lint },
		{
			"ray-x/lsp_signature.nvim",
			tag = "v0.3.1",
			config = function()
				require("lsp_signature").setup()
			end,
		},
		{
			"nvimdev/lspsaga.nvim",
			commit = "4ce44df",
			dependencies = {
				{
					"nvim-treesitter/nvim-treesitter",
					tag = "v0.9.2",
					config = function()
						require("nvim-treesitter.configs").setup(conf.nvim_treesitter)
					end,
				},
				{ "nvim-tree/nvim-web-devicons", tag = "v0.100" },
			},
			config = function()
				require("lspsaga").setup(conf.lspsaga)
				keyb.lspsaga()
			end,
		},
		{
			"lervag/vimtex",
			tag = "v2.15",
			init = function()
				conf.vimtex()
			end,
			config = function()
				keyb.vimtex()
			end,
		},
	},
	checker = { enabled = true },
})
