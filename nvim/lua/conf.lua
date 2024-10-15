local vim = vim
local conf = {}

conf.auto_restore_cursor_pos = function()
	vim.api.nvim_create_autocmd({ "BufReadPost" }, {
		pattern = { "*" },
		callback = function()
			vim.api.nvim_exec('silent! normal! g`"zv', false)
		end,
	})
end

conf.nvt = function(kb)
	return {
		on_attach = kb,
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
	}
end

conf.material = {
	contrast = {
		sidebars = true,
		floating_windows = true,
		cursor_line = true,
		non_current_windows = true,
	},
	plugins = {
		"fidget",
		"gitsigns",
		"hop",
		"indent-blankline",
		"lspsaga",
		"nvim-tree",
		"nvim-cmp",
		"telescope",
		"which-key",
		"nvim-notify",
	},
	high_visibility = {
		lighter = true,
		darker = true,
	},
	lualine_style = "default",
}

conf.lualine = {
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
}

conf.ibl_hook = function()
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
end
conf.ibl = {
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
}

conf.bufferline = {
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
	},
}

conf.copilot = {
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
}

conf.nvim__engines = {
	-- { type = "lsp", mason_id = "pyright", lspconfig_id = "pyright" },
	{ type = "lsp", mason_id = "python-lsp-server", lspconfig_id = "pylsp" },
	{ type = "lsp", mason_id = "clangd", lspconfig_id = "clangd" },
	{ type = "lsp", mason_id = "lua-language-server", lspconfig_id = "lua_ls" },
	{ type = "lsp", mason_id = "bash-language-server", lspconfig_id = "bashls" },
	{ type = "lsp", mason_id = "gopls", lspconfig_id = "gopls" },
	{ type = "lsp", mason_id = "texlab", lspconfig_id = "texlab" },
	{ type = "formatter", mason_id = "codespell" },
	{ type = "formatter", mason_id = "isort" },
	{ type = "formatter", mason_id = "black" },
	{ type = "formatter", mason_id = "stylua" },
	{ type = "formatter", mason_id = "prettier" },
	{ type = "formatter", mason_id = "gofumpt" },
	{ type = "formatter", mason_id = "latexindent" },
	{ type = "formatter", mason_id = "bibtex-tidy" },
	-- { type = "lint", mason_id = "pylint" }, -- wrongly hint not import error
	{ type = "lint", mason_id = "ruff" },
	{ type = "lint", mason_id = "luacheck" },
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
	-- https://mason-registry.dev/registry/list#yaml-language-server
}
conf.lspconfig__engines = {}
conf.mason__auto_install = {}
for _, k in ipairs(conf.nvim__engines) do
	table.insert(conf.mason__auto_install, k["mason_id"])
	if k["type"] == "lsp" then
		conf.lspconfig__engines[#conf.lspconfig__engines + 1] = k["lspconfig_id"]
	end
end

conf.telescope = {
	defaults = {
		scroll_strategy = "limit",
	},
}

conf.conform = {
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
}

conf.nvim_lint = function()
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
end

conf.mason_tool_installer = {
	ensure_installed = conf.mason__auto_install,
}

conf.cmp = function(keyb)
	local cmp = require("cmp")
	cmp.setup({
		mapping = keyb,
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
	})
end

conf.lsp_config = function()
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local lc = require("lspconfig")
	for _, engine in ipairs(conf.lspconfig__engines) do
		lc[engine].setup({ capabilities = capabilities })
	end
end

conf.lsp_signature = {
	handler_opts = { border = "single" },
	hi_parameter = "LspSignatureActiveParameter",
}

conf.nvim_treesitter = {
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
}

return conf
