local vim = vim

local kb = {}
local map = vim.keymap.set
local opt = function(desc)
	return { desc = desc, noremap = true, silent = true, nowait = true }
end

kb.basic = function()
	map("n", "<leader>w", ":wa<CR>", opt("[basic] File Save"))
	map("n", "<leader><CR>", ":noh<CR>", opt("[basic] No Highlight"))
	map("v", "<", "<gv", opt("[basic] Indent >"))
	map("v", ">", ">gv", opt("[basic] Indent <"))
end

kb.window = function()
	map("n", "<C-w>c", ":close<CR>", opt("[builtin] Window Close"))
	map("n", "<C-w>>", ":vertical resize +20<CR>", opt("[builtin] Window Resize +w"))
	map("n", "<C-w><", ":vertical resize -20<CR>", opt("[builtin] Window Resize -w"))
	map("n", "<C-w>+", ":resize +10<CR>", opt("[builtin] Window Resize +h"))
	map("n", "<C-w>-", ":resize -10<CR>", opt("[builtin] Window Resize -h"))
end

kb.tab = function()
	map("n", "<C-t>C", ":tabclose<CR>", opt())
	map("n", "<C-t>c", ":tabnew<CR>", opt())
	map("n", "<C-t>n", ":tabnext<CR>", opt())
	map("n", "<C-t>p", ":tabprevious<CR>", opt())
end

kb.bufferline = {
	{ "<C-h>", ":BufferLineCyclePrev<CR>", "n", desc = "[bufferline] Prev" },
	{ "<C-l>", ":BufferLineCycleNext<CR>", "n", desc = "[bufferline] Next" },
}

kb.bufdelete = {
	{ "<C-w>d", ":Bdelete<CR>", "n", desc = "[bufdelete] Delete Buffer" },
}

kb.nvt = {
	{ "<leader>nn", ":NvimTreeToggle<CR>", "n", desc = "[nvt] Toggle Nvim-Tree" },
}

kb.nvt_buf = function(bufnr)
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
end

kb.hop = {
	{ "fw", ":HopWord<CR>", "n", desc = "[hop] Find Words" },
}

kb.telescope = {
	{ "<leader>ff", ":Telescope find_files<CR>", "n", desc = "[telescope] Find Files" },
	{ "<leader>fg", ":Telescope live_grep<CR>", "n", desc = "[telescope] Find Greps" },
	{ "<leader>fb", ":Telescope buffers<CR>", "n", desc = "[telescope] Find Buffers" },
}

kb.conform = {
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
		desc = "[conform] Format Code",
	},
}

kb.cmp = function()
	local cmp = require("cmp")
	return {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<CR>"] = cmp.mapping.confirm({
			select = true,
			behavior = cmp.ConfirmBehavior.Replace,
		}),
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
	}
end

kb.gitsigns = {
	{ "gv", ":Gitsigns preview_hunk<CR>", "n", desc = "[gitsigns] Preview Hunk" },
	{ "ga", ":Gitsigns stage_hunk<CR>", "n", desc = "[gitsigns] Undo Stage Hunk" },
	{ "gu", ":Gitsigns undo_stage_hunk<CR>", "n", desc = "[gitsigns] Undo Stage Hunk" },
	{ "<leader>gp", ":Gitsigns prev_hunk<CR>", "n", desc = "[gitsigns] Prev Hunk" },
	{ "<leader>gn", ":Gitsigns next_hunk<CR>", "n", desc = "[gitsigns] Next Hunk" },
}

kb.lspsaga = {
	-- map("n", "gD", vim.lsp.buf.declaration, opt("[lsp] go declaration"))
	{ "gd", ":Lspsaga peek_definition<CR>", "n", desc = "[lspsaga] Show Def" },
	{ "<leader>gd", vim.lsp.buf.definition, "n", desc = "[lsp] Go Def" },
	{ "gr", ":Lspsaga finder<CR>", "n", desc = "[lspsaga] Peek Ref" },
	{ "<leader>gr", vim.lsp.buf.references, "n", desc = "[lsp] Go Ref" },

	-- map("n", "gh", vim.lsp.buf.hover, opt("[lsp] hover help"))
	{ "K", ":Lspsaga hover_doc<CR>", "n", desc = "[lspsaga] Hover Doc" },
	-- map("n", "<C-k>", vim.lsp.buf.signature_help, opt())

	{ "<leader>rn", ":Lspsaga rename<CR>", "n", desc = "[lspsaga] Renam" },
	{ "<leader>o", ":Lspsaga outline<CR>", "n", desc = "[lspsaga] Toggle Outline" },

	-- { "<leader>gci", ":Lspsaga incoming_calls<CR>", "n", desc = "[lspsaga] Show In Calls" },
	-- { "<leader>gco", ":Lspsaga outgoing_calls<CR>", "n", desc = "[lspsaga] Show Out Calls" },
	{ "<leader>ca", ":Lspsaga code_action<CR>", "n", desc = "[lspsaga] Code Action" },
	{ "gO", ":Lspsaga show_line_diagnostics<CR>", "n", desc = "[lspsaga] Show Diag Line" },
	{ "go", ":Lspsaga show_cursor_diagnostics<CR>", "n", desc = "[lspsaga] Show Diag Cur" },
	{ "gp", ":Lspsaga diagnostic_jump_prev<CR>", "n", desc = "[lspsaga] Show Diag Prev" },
	{ "gn", ":Lspsaga diagnostic_jump_next<CR>", "n", desc = "[lspsaga] Show Diag Next" },
}

return kb
