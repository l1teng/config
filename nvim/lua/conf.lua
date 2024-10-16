local K = {}

local __nvim_engines = {
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
	{ type = "lint", mason_id = "ruff" },
	{ type = "lint", mason_id = "luacheck" },
	-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
	-- https://mason-registry.dev/registry/list#yaml-language-server
}
K.lsps = {}
local __mason_list = {}
for _, k in ipairs(__nvim_engines) do
	table.insert(__mason_list, k["mason_id"])
	if k["type"] == "lsp" then
		K.lsps[#K.lsps + 1] = k["lspconfig_id"]
	end
end
K.msti = {
	ensure_installed = __mason_list,
}

return K
