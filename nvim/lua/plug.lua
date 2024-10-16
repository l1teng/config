local vim = vim
local jit = jit

local conf = require("conf")

local map = vim.keymap.set
local opt = function(desc)
	return { desc = desc, noremap = true, silent = true, nowait = true }
end

local cmp = require("cmp")

local K = {}

K.comment = {
	"numToStr/Comment.nvim",
	tag = "v0.8.0",
	lazy = false,
	opts = { mappings = { extra = false } },
}

K.autopairs = {
	"windwp/nvim-autopairs",
	commit = "fd2badc",
	lazy = false,
	opts = {},
}

K.lsp_cfg = {
	"neovim/nvim-lspconfig",
	tag = "v0.1.8",
}

K.navic = {
	"SmiteshP/nvim-navic",
	commit = "8649f69",
	lazy = true,
	dependencies = {
		K.lsp_cfg,
	},
	opts = {},
}

K.barbecue = {
	"utilyre/barbecue.nvim",
	tag = "v1.2.0",
	lazy = false,
	dependencies = {
		K.navic,
	},
	opts = {
		-- extra
		theme = "tokyonight",
	},
}

K.bufdel = {
	"famiu/bufdelete.nvim",
	commit = "f6bcea7",
	lazy = true,
	keys = {
		{ "<C-w>d", ":Bdelete<CR>", "n", desc = "[bufdelete] delete buffer" },
	},
}

K.bufline = {
	"akinsho/bufferline.nvim",
	tag = "v4.7.0",
	lazy = false,
	init = function()
		vim.opt.termguicolors = true
	end,
	opts = {
		options = {
			numbers = "ordinal",
			buffer_close_icon = "",
			indicator = { style = "underline" },
			tab_size = 9,
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level)
				local icon = level:match("error") and "x" or "!"
				return "[" .. icon .. count .. "]"
			end,
			show_buffer_icons = false,
			show_tab_indicators = true,
			separator_style = "slope",
		},
	},
	keys = {
		{ "<C-h>", ":BufferLineCyclePrev<CR>", "n", desc = "[bufferline] previous buffer" },
		{ "<C-l>", ":BufferLineCycleNext<CR>", "n", desc = "[bufferline] next buffer" },
	},
	dependencies = {
		K.devicons,
	},
}

K.lspkind = { "onsails/lspkind.nvim", commit = "cff4ae3" }
K.cmp_buf = { "hrsh7th/cmp-buffer", commit = "3022dbc" }
K.cmp_pth = { "hrsh7th/cmp-path", commit = "91ff86c" }
K.frd_snip = { "rafamadriz/friendly-snippets", branch = "main" }
K.vsnip = {
	"hrsh7th/vim-vsnip",
	commit = "02a8e79",
	dependencies = {
		K.frd_snip,
	},
}
K.cmp_vsnip = {
	"hrsh7th/cmp-vsnip",
	commit = "989a8a7",
	dependencies = {
		K.vsnip,
	},
}
K.cmp_lsp = {
	"hrsh7th/cmp-nvim-lsp",
	commit = "39e2eda",
	dependencies = {
		K.lsp_cfg,
	},
	config = function()
		local lc = require("lspconfig")
		for _, engine in ipairs(conf.lsps) do
			lc[engine].setup({ capabilities = require("cmp_nvim_lsp").default_capabilities() })
		end
	end,
}
K.copilot = {
	"zbirenbaum/copilot.lua",
	commit = "86537b2",
	opts = {
		panel = { enabled = false },
		suggestion = { enabled = false },
		filetypes = {
			yaml = false,
			markdown = false,
			help = false,
			gitcommit = false,
			gitrebase = false,
			hgcommit = false,
			svn = false,
			cvs = false,
			["."] = false,
		},
	},
}
K.cmp_copilot = {
	"zbirenbaum/copilot-cmp",
	commit = "b6e5286",
	dependencies = {
		K.copilot,
	},
	opts = {},
}
K.cmp = {
	"hrsh7th/nvim-cmp",
	commit = "ae644fe",
	lazy = false,
	dependencies = {
		K.lspkind,
		K.cmp_buf,
		K.cmp_pth,
		K.cmp_vsnip,
		K.cmp_lsp,
		K.cmp_copilot,
	},
	opts = {
		mapping = {
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<CR>"] = cmp.mapping.confirm({
				select = true,
				behavior = cmp.ConfirmBehavior.Replace,
			}),
			["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		},
		sources = {
			{ name = "copilot", priority = 4 },
			{ name = "vsnip", priority = 3 },
			{ name = "nvim_lsp", priority = 2 },
			{ name = "path", priority = 1 },
			{ name = "buffer", priority = 0 },
		},
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body)
			end,
		},
		formatting = {
			format = require("lspkind").cmp_format({
				mode = "symbol",
				maxwidth = 50,
				ellipsis_char = "...",
				show_labelDetails = true,
				before = function(entry, vim_item)
					vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
					return vim_item
				end,
			}),
		},
	},
}

K.conform = {
	"stevearc/conform.nvim",
	branch = "nvim-0.9",
	lazy = true,
	opts = {
		formatters = {
			black = {
				prepend_args = {
					"--line-length",
					"79",
					"--target-version",
					"py39",
				},
			},
		},
		formatters_by_ft = {
			python = {
				"isort",
				"black",
			},
			lua = { "stylua" },
			yaml = { "prettier" },
			json = { "prettier" },
			["*"] = { "codespell" },
			["_"] = { "trim_whitespace" },
		},
	},
	keys = {
		{
			"<leader>fm",
			function()
				vim.notify("Formatting code...")
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 5000,
				})
				vim.notify("Formatting code...\nDone.")
			end,
			"n",
			desc = "[conform] format code",
		},
	},
}

K.dap = {
	"mfussenegger/nvim-dap",
	tag = "0.8.0",
	lazy = false,
	keys = {
		{ "da", ':lua require("dap").toggle_breakpoint()<CR>', "n", desc = "[dap] add breakpoint" },
		{ "dt", ':lua require("dap").terminate()<CR>', "n", desc = "[dap] terminate" },
		{ "dc", ':lua require("dap").continue()<CR>', "n", desc = "[dap] continue" },
		{ "di", ':lua require("dap").step_into()<CR>', "n", desc = "[dap] step into" },
		{ "do", ':lua require("dap").step_over()<CR>', "n", desc = "[dap] step over" },
	},
	config = function()
		require("dap").listeners.before.attach.dapui_config = function()
			require("dapui").open()
		end
		require("dap").listeners.before.launch.dapui_config = function()
			require("dapui").open()
		end
		require("dap").listeners.before.event_terminated.dapui_config = function()
			require("dapui").close()
		end
		require("dap").listeners.before.event_exited.dapui_config = function()
			require("dapui").close()
		end
		-- python
		require("dap").adapters.python = {
			type = "executable",
			command = "python",
			args = { "-m", "debugpy.adapter" },
		}
		require("dap").configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = function()
					return "python"
				end,
			},
		}
	end,
}
K.nio = { "nvim-neotest/nvim-nio" }
K.dap_ui = {
	"rcarriga/nvim-dap-ui",
	tag = "v4.0.0",
	lazy = false,
	opts = {
		layouts = {
			{
				elements = {
					{
						id = "scopes",
						size = 0.5,
					},
					{
						id = "breakpoints",
						size = 0.2,
					},
					{
						id = "repl",
						size = 0.3,
					},
				},
				position = "left",
				size = 40,
			},
			{
				elements = {
					{
						id = "console",
						size = 1.0,
					},
				},
				position = "bottom",
				size = 5,
			},
		},
	},
	dependencies = { K.dap, K.nio },
}

K.devicons = { "nvim-tree/nvim-web-devicons", tag = "v0.100", lazy = true }

K.fidget = {
	"j-hui/fidget.nvim",
	tag = "v1.4.5",
	lazy = false,
	opts = {},
}

K.gs = {
	"lewis6991/gitsigns.nvim",
	commit = "1ef74b5",
	lazy = false,
	opts = {},
	keys = {
		{ "gv", ":Gitsigns preview_hunk<CR>", "n", desc = "[gitsigns] preview hunk" },
		{ "ga", ":Gitsigns stage_hunk<CR>", "n", desc = "[gitsigns] stage hunk" },
		{ "gu", ":Gitsigns undo_stage_hunk<CR>", "n", desc = "[gitsigns] undo last stage hunk" },
		{ "<leader>gp", ":Gitsigns prev_hunk<CR>", "n", desc = "[gitsigns] previous hunk" },
		{ "<leader>gn", ":Gitsigns next_hunk<CR>", "n", desc = "[gitsigns] previous hunk" },
	},
}

K.tst = {
	"nvim-treesitter/nvim-treesitter",
	tag = "v0.9.2",
	lazy = true,
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = {
			-- frontend
			"html",
			"css",
			"javascript",
			-- script
			"python",
			"lua",
			"vim",
			-- compile
			"go",
			"c",
			"cpp",
			-- doc
			"vimdoc",
			"markdown",
			-- doc - compile
			"latex",
		},
	},
}

K.lint = {
	"mfussenegger/nvim-lint",
	comment = "f707b3a",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			python = { "ruff" },
			lua = { "luacheck" },
		}
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
	lazy = false,
}

K.lspsaga = {
	"nvimdev/lspsaga.nvim",
	commit = "4ce44df",
	dependencies = {
		K.tst,
	},
	opts = {},
	keys = {
		-- map("n", "gD", vim.lsp.buf.declaration, opt("[lsp] go declaration"))
		{ "gd", ":Lspsaga peek_definition<CR>", "n", desc = "[lspsaga] peek definition" },
		{ "<leader>gd", vim.lsp.buf.definition, "n", desc = "[lsp] goto definition" },
		{ "gr", ":Lspsaga finder<CR>", "n", desc = "[lspsaga] peek references" },
		{ "<leader>gr", vim.lsp.buf.references, "n", desc = "[lsp] goto references" },

		-- map("n", "gh", vim.lsp.buf.hover, opt("[lsp] hover help"))
		{ "K", ":Lspsaga hover_doc<CR>", "n", desc = "[lspsaga] hover help document" },
		-- map("n", "<C-k>", vim.lsp.buf.signature_help, opt())

		{ "<leader>rn", ":Lspsaga rename<CR>", "n", desc = "[lspsaga] rename" },
		{ "<leader>o", ":Lspsaga outline<CR>", "n", desc = "[lspsaga] toggle outline" },

		-- { "<leader>gci", ":Lspsaga incoming_calls<CR>", "n", desc = "[lspsaga] Show In Calls" },
		-- { "<leader>gco", ":Lspsaga outgoing_calls<CR>", "n", desc = "[lspsaga] Show Out Calls" },
		{ "<leader>ca", ":Lspsaga code_action<CR>", "n", desc = "[lspsaga] show code actions" },
		{ "gO", ":Lspsaga show_line_diagnostics<CR>", "n", desc = "[lspsaga] peek line diagnostics" },
		{ "go", ":Lspsaga show_cursor_diagnostics<CR>", "n", desc = "[lspsaga] peek cursor diagnostics" },
		{ "gp", ":Lspsaga diagnostic_jump_prev<CR>", "n", desc = "[lspsaga] goto previous diagnostics" },
		{ "gn", ":Lspsaga diagnostic_jump_next<CR>", "n", desc = "[lspsaga] goto next diagnostics" },
	},
}

K.lsp_sig = {
	"ray-x/lsp_signature.nvim",
	tag = "v0.3.1",
	lazy = false,
	opts = {
		handler_opts = { border = "single" },
		hi_parameter = "LspSignatureActiveParameter",
	},
}

K.lualine = {
	"nvim-lualine/lualine.nvim",
	commit = "b431d22",
	lazy = false,
	opts = {
		-- extra
		theme = "tokyonight",
		options = {
			icons_enabled = false,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			always_divide_middle = true,
			globalstatus = false,
			refresh = { statusline = 200 },
		},
		sections = {
			lualine_a = { "mode", "tabs" },
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "encoding", "filetype" },
			lualine_y = {},
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = { "mode", "tabs" },
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "encoding", "filetype" },
			lualine_y = {},
			lualine_z = { "location" },
		},
		extensions = { "lazy", "nvim-tree" },
	},
}

K.plenary = { "nvim-lua/plenary.nvim", tag = "v0.1.4", lazy = true }

K.tsc = {
	"nvim-telescope/telescope.nvim",
	commit = "df534c3",
	lazy = true,
	dependencies = { K.plenary },
	opts = {
		defaults = {
			scroll_strategy = "limit",
		},
	},
	keys = {
		{ "<leader>ff", ":Telescope find_files<CR>", "n", desc = "[telescope] find files" },
		{ "<leader>fg", ":Telescope live_grep<CR>", "n", desc = "[telescope] find grep" },
		{ "<leader>fb", ":Telescope buffers<CR>", "n", desc = "[telescope] find buffers" },
	},
}

local function toggle_telescope(harpoon_files)
	local ts_conf = require("telescope.config").values
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = ts_conf.file_previewer({}),
			sorter = ts_conf.generic_sorter({}),
		})
		:find()
end
K.harpoon = {
	"ThePrimeagen/harpoon",
	commit = "0378a6c",
	lazy = true,
	opts = {},
	keys = {
		{
			"<leader>ha",
			function()
				require("harpoon"):list():add()
			end,
			"n",
			desc = "[harpoon] add tag",
		},
		{
			"<leader>hh",
			function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
			end,
			"n",
			desc = "[harpoon] show tags",
		},
		{
			"<leader>ht",
			function()
				toggle_telescope(require("harpoon"):list())
			end,
			"n",
			desc = "[harpoon] show tags (in telescope)",
		},
		{
			"<leader>hp",
			function()
				require("harpoon"):list():prev()
			end,
			"n",
			desc = "[harpoon] goto previous tag",
		},
		{
			"<leader>hn",
			function()
				require("harpoon"):list():next()
			end,
			"n",
			desc = "[harpoon] goto next tag",
		},
	},
	dependencies = {
		K.tsc,
	},
}

K.hop = {
	"phaazon/hop.nvim",
	tag = "v2.0.3",
	lazy = true,
	opts = { keys = "etovxqpdygfblzhckisuran" },
	keys = {
		{ "fw", ":HopWord<CR>", "n", desc = "[hop] find words" },
	},
}

K.ibl = {
	"lukas-reineke/indent-blankline.nvim",
	tag = "v3.7.2",
	lazy = false,
	config = function()
		local hooks = require("ibl.hooks")
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
		end)
		require("ibl").setup({
			indent = {
				highlight = {
					"RainbowRed",
					"RainbowYellow",
					"RainbowBlue",
					"RainbowOrange",
					"RainbowGreen",
					"RainbowViolet",
					"RainbowCyan",
				},
			},
		})
	end,
}

K.illuminate = { "RRethy/vim-illuminate", commit = "5eeb795", lazy = false }

K.msti = {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	commit = "c5e07b8",
	lazy = true,
	opts = conf.msti,
}

K.mason = {
	"williamboman/mason.nvim",
	tag = "v1.10.0",
	lazy = false,
	dependencies = {
		K.msti,
	},
	opts = {},
}

K.notify = {
	"rcarriga/nvim-notify",
	tag = "v3.13.5",
	lazy = false,
	config = function()
		vim.notify = require("notify")
	end,
}

K.nvt = {
	"nvim-tree/nvim-tree.lua",
	commit = "cb57691",
	lazy = true,
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		vim.opt.termguicolors = true
	end,
	opts = {
		on_attach = function(bufnr)
			local nvt_api = require("nvim-tree.api")
			local nvt_opt = function(desc)
				local _opt_ori = opt(desc)
				_opt_ori["buffer"] = bufnr
				return _opt_ori
			end
			map("n", "o", nvt_api.node.open.edit, nvt_opt("[nvim-tree] Open"))
			map("n", "C", nvt_api.tree.change_root_to_node, nvt_opt("[nvim-tree] CD"))
			map("n", ">", nvt_api.node.navigate.sibling.next, nvt_opt("[nvim-tree] Next Sibling"))
			map("n", "<", nvt_api.node.navigate.sibling.prev, nvt_opt("[nvim-tree] Previous Sibling"))
			map("n", "P", nvt_api.node.navigate.parent, nvt_opt("[nvim-tree] Parent Directory"))
			map("n", "K", nvt_api.node.navigate.sibling.first, nvt_opt("[nvim-tree] First Sibling"))
			map("n", "J", nvt_api.node.navigate.sibling.last, nvt_opt("[nvim-tree] Last Sibling"))
			map("n", "H", nvt_api.tree.toggle_hidden_filter, nvt_opt("[nvim-tree] Toggle Dotfiles"))
			map("n", "I", nvt_api.tree.toggle_gitignore_filter, nvt_opt("[nvim-tree] Toggle Git Ignore"))
			map("n", "R", nvt_api.tree.reload, nvt_opt("[nvim-tree] Refresh"))
			map("n", "a", nvt_api.fs.create, nvt_opt("[nvim-tree] Create"))
			map("n", "d", nvt_api.fs.remove, nvt_opt("[nvim-tree] Delete"))
			map("n", "r", nvt_api.fs.rename, nvt_opt("[nvim-tree] Rename"))
			map("n", "x", nvt_api.fs.cut, nvt_opt("[nvim-tree] Cut"))
			map("n", "c", nvt_api.fs.copy.node, nvt_opt("[nvim-tree] Copy"))
			map("n", "p", nvt_api.fs.paste, nvt_opt("[nvim-tree] Paste"))
			map("n", "gy", nvt_api.fs.copy.absolute_path, nvt_opt("[nvim-tree] Copy Absolute Path"))
			map("n", "y", nvt_api.fs.copy.filename, nvt_opt("[nvim-tree] Copy Name"))
			map("n", "Y", nvt_api.fs.copy.relative_path, nvt_opt("[nvim-tree] Copy Relative Path"))
			map("n", "U", nvt_api.tree.change_root_to_parent, nvt_opt("[nvim-tree] Up"))
			map("n", "F", nvt_api.live_filter.clear, nvt_opt("[nvim-tree] Clean Filter"))
			map("n", "f", nvt_api.live_filter.start, nvt_opt("[nvim-tree] Filter"))
			-- map('n', 'q',   nvt_api.tree.close,                   nvt_opt('[nvim-tree] Close'))
			map("n", "W", nvt_api.tree.collapse_all, nvt_opt("[nvim-tree] Collapse"))
			map("n", "E", nvt_api.tree.expand_all, nvt_opt("[nvim-tree] Expand All"))
			map("n", "S", nvt_api.tree.search_node, nvt_opt("[nvim-tree] Search"))
			map("n", "g?", nvt_api.tree.toggle_help, nvt_opt("[nvim-tree] Help"))
			map("n", "m", nvt_api.marks.toggle, nvt_opt("[nvim-tree] Toggle Bookmark"))
			map("n", "bmv", nvt_api.marks.bulk.move, nvt_opt("[nvim-tree] Move Bookmarked"))
		end,
		hijack_cursor = true,
		auto_reload_on_write = true,
		create_in_closed_folder = false,
		disable_netrw = true,
		hijack_unnamed_buffer_when_opening = false,
		view = {
			relativenumber = true,
			adaptive_size = true,
			float = {
				enable = true,
			},
		},
		renderer = {
			indent_markers = {
				enable = true,
			},
			icons = {
				web_devicons = {
					file = {
						enable = false,
					},
					folder = {
						enable = false,
					},
				},
				git_placement = "before",
				symlink_arrow = " -> ",
				glyphs = {
					default = "f",
					symlink = "s",
					bookmark = "#",
					modified = "x",
					hidden = "f",
					folder = {
						arrow_closed = ">",
						arrow_open = "\\",
						default = "F",
						open = "F",
						empty = "F",
						empty_open = "F",
						symlink = "S",
						symlink_open = "S",
					},
					git = {
						unstaged = "✗",
						staged = "✓",
						unmerged = "",
						renamed = "➜",
						untracked = "★",
						deleted = "",
						ignored = "◌",
					},
				},
			},
		},
		git = {
			timeout = 5000,
		},
		filters = {
			dotfiles = true,
			custom = { "node_modules", "__pycache__" },
			exclude = { ".gitignore", ".gitkeep", ".vscode" },
		},
	},
	keys = {
		{ "<leader>nn", ":NvimTreeToggle<CR>", "n", desc = "[nvt] toggle nvim-tree" },
	},
}

K.tmux = { "aserowy/tmux.nvim", commit = "65ee9d6", lazy = false }

K.tokyonight = {
	"folke/tokyonight.nvim",
	tag = "v4.8.0",
	lazy = false,
	opts = {
		style = "night",
		light_style = "day",
		dim_inactive = true,
		lualine_bold = true,
		on_colors = function(c)
			c.border = c.blue0
			-- colors.border = "#565f89"
		end,
	},
	init = function()
		vim.cmd("colorscheme tokyonight")
	end,
}

K.vimtex = {
	"lervag/vimtex",
	tag = "v2.15",
	lazy = true,
	ft = { "tex", "plaintex", "bib" },
	init = function()
		vim.g.vimtex_view_method = (jit.os:lower() == "osx") and "skim" or ""
		vim.g.vimtex_quickfix_open_on_warning = 0
	end,
}

K.wk = {
	"folke/which-key.nvim",
	tag = "v3.13.2",
	lazy = false,
	opts = {},
}

return K
