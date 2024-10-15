local vim = vim
local jit = jit
local conf = require("conf")
local keyb = require("keybind")

local K = {}

K.bufdelete = {
	"famiu/bufdelete.nvim",
	commit = "f6bcea7",
	keys = keyb.bufdelete,
}
K.cmp_buf = { "hrsh7th/cmp-buffer", commit = "3022dbc" }
K.copilot = {
	"zbirenbaum/copilot.lua",
	commit = "86537b2",
	opts = conf.copilot,
}
K.cmp_copilot = {
	"zbirenbaum/copilot-cmp",
	commit = "b6e5286",
	dependencies = {
		K.copilot,
	},
	opts = {},
}
K.lsp_cfg = {
	"neovim/nvim-lspconfig",
	tag = "v0.1.8",
}
K.cmp_lsp = {
	"hrsh7th/cmp-nvim-lsp",
	commit = "39e2eda",
	dependencies = {
		K.lsp_cfg,
	},
	config = function()
		conf.lsp_config()
	end,
}
K.cmp_pth = { "hrsh7th/cmp-path", commit = "91ff86c" }
K.fsnip = { "rafamadriz/friendly-snippets", branch = "main" }
K.vsnip = {
	"hrsh7th/vim-vsnip",
	commit = "02a8e79",
	dependencies = {
		K.fsnip,
	},
}
K.cmp_vsnip = {
	"hrsh7th/cmp-vsnip",
	commit = "989a8a7",
	dependencies = {
		K.vsnip,
	},
}
K.lspkind = { "onsails/lspkind.nvim", commit = "cff4ae3" }
K.cmp = {
	"hrsh7th/nvim-cmp",
	commit = "ae644fe",
	dependencies = {
		K.lspkind,
		K.cmp_buf,
		K.cmp_pth,
		K.cmp_vsnip,
		K.cmp_lsp,
		K.cmp_copilot,
	},
	config = function()
		conf.cmp(keyb.cmp())
	end,
}
K.conform = {
	"stevearc/conform.nvim",
	branch = "nvim-0.9",
	opts = conf.conform,
	keys = keyb.conform,
}
K.comment = {
	"numToStr/Comment.nvim",
	tag = "v0.8.0",
	opts = { mappings = { extra = false } },
}
K.devicons = { "nvim-tree/nvim-web-devicons", tag = "v0.100" }
K.bufferline = {
	"akinsho/bufferline.nvim",
	tag = "v4.7.0",
	dependencies = {
		K.devicons,
	},
	init = function()
		vim.opt.termguicolors = true
	end,
	opts = conf.bufferline,
	keys = keyb.bufferline,
}
K.fidget = {
	"j-hui/fidget.nvim",
	tag = "v1.4.5",
	opts = {},
}
K.gs = {
	"lewis6991/gitsigns.nvim",
	commit = "1ef74b5",
	opts = {},
	keys = keyb.gitsigns,
}
K.telescope = {
	"nvim-telescope/telescope.nvim",
	commit = "df534c3",
	dependencies = { { "nvim-lua/plenary.nvim", tag = "v0.1.4" } },
	opts = conf.telescope,
	keys = keyb.telescope,
}
K.harpoon = {
	"ThePrimeagen/harpoon",
	commit = "0378a6c",
	opts = {},
	keys = keyb.harpoon,
	dependencies = {
		K.telescope,
	},
}
K.hop = {
	"phaazon/hop.nvim",
	tag = "v2.0.3",
	opts = { keys = "etovxqpdygfblzhckisuran" },
	keys = keyb.hop,
}
K.ibl = {
	"lukas-reineke/indent-blankline.nvim",
	tag = "v3.7.2",
	config = function()
		conf.ibl_hook()
		require("ibl").setup(conf.ibl)
	end,
}
K.illuminate = { "RRethy/vim-illuminate", commit = "5eeb795" }
K.lualine = {
	"nvim-lualine/lualine.nvim",
	commit = "b431d22",
	opts = conf.lualine,
}
K.treesitter = {
	"nvim-treesitter/nvim-treesitter",
	tag = "v0.9.2",
	main = "nvim-treesitter.configs",
	opts = conf.nvim_treesitter,
}
K.lsp_sig = {
	"ray-x/lsp_signature.nvim",
	tag = "v0.3.1",
	opts = {},
}
K.lspsaga = {
	"nvimdev/lspsaga.nvim",
	commit = "4ce44df",
	dependencies = {
		K.treesitter,
		K.devicons,
	},
	opts = {},
	keys = keyb.lspsaga,
}
K.mason_it = {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	commit = "c5e07b8",
	config = function()
		require("mason-tool-installer").setup(conf.mason_tool_installer)
	end,
}
K.mason = {
	"williamboman/mason.nvim",
	tag = "v1.10.0",
	dependencies = {
		K.mason_it,
	},
	opts = {},
}
K.notify = {
	"rcarriga/nvim-notify",
	tag = "v3.13.5",
	config = function()
		vim.notify = require("notify")
	end,
}
K.nva = {
	"windwp/nvim-autopairs",
	commit = "fd2badc",
	opts = {},
}
K.nvl = { "mfussenegger/nvim-lint", branch = "master", config = conf.nvim_lint }
K.nvt = {
	"nvim-tree/nvim-tree.lua",
	commit = "cb57691",
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		vim.o.termguicolors = true
		vim.opt.termguicolors = true
	end,
	opts = conf.nvt(keyb.nvt_buf),
	keys = keyb.nvt,
}
K.tmux = { "aserowy/tmux.nvim", commit = "65ee9d6" }
K.vimtex = {
	"lervag/vimtex",
	tag = "v2.15",
	ft = { "tex", "plaintex", "bib" },
	init = function()
		vim.g.vimtex_view_method = (jit.os:lower() == "osx") and "skim" or ""
		vim.g.vimtex_quickfix_open_on_warning = 0
	end,
}
K.which_key = {
	"folke/which-key.nvim",
	tag = "v3.13.2",
	opts = {},
}
K.material = {
	"marko-cerovac/material.nvim",
	commit = "ac8f02e",
	dependencies = {
		K.fidget,
		K.gs,
		K.harpoon,
		K.hop,
		K.illuminate,
		K.ibl,
		K.lspsaga,
		K.nvt,
		K.cmp,
		K.telescope,
		K.which_key,
		K.notify,
		K.lualine,
	},
	init = function()
		vim.g.material_style = "darker"
		vim.cmd([[colorscheme material]])
	end,
	opts = conf.material,
}

return K
