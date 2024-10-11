local vim = vim

local kb = {}
local map = vim.keymap.set
local opt = function(desc)
	return { desc = desc, noremap = true, silent = true, nowait = true }
end

kb.basic = function()
	map("n", "<leader>w", function()
		vim.cmd("wa")
	end, opt("[basic] File Save"))
	map("n", "<leader><CR>", function()
		vim.cmd("noh")
	end, opt("[basic] No Highlight"))
	map("v", "<", "<gv", opt("[basic] Indent >"))
	map("v", ">", ">gv", opt("[basic] Indent <"))
	-- fold
	-- vim.cmd([[set foldmethod=indent]])
end

kb.window = function()
	map("", "<C-w>c", ":close<CR>", opt("[builtin] Window Close"))
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

kb.lsp = function()
	map("n", "gD", vim.lsp.buf.declaration, opt("[lsp] go declaration"))
	map("n", "gd", vim.lsp.buf.definition, opt("[lsp] go defeinition"))
	map("n", "gr", vim.lsp.buf.references, opt("[lsp] go references"))
	map("n", "gh", vim.lsp.buf.hover, opt("[lsp] hover help"))
	map("n", "<C-k>", vim.lsp.buf.signature_help, opt())
end

kb.material = function() end

kb.bufferline = function()
	map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt("[bufferline] Prev"))
	map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt("[bufferline] Next"))
end

kb.bufdelete = function()
	map("n", "<C-w>d", ":Bdelete<CR>", opt("[bufdelete] Delete Buffer"))
end

kb.nvt = function()
	map("n", "<leader>nn", ":NvimTreeToggle<CR>", opt("[nvt] Toggle Nvim-Tree"))
end

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

kb.hop = function()
	map("n", "fw", ":HopWord<CR>", opt("[hop] Find Words"))
end

kb.telescope = function()
	map("n", "<leader>ff", ":Telescope find_files<CR>", opt("[telescope] Find Files"))
	map("n", "<leader>fg", ":Telescope live_grep<CR>", opt("[telescope] Find Greps"))
	map("n", "<leader>fb", ":Telescope buffers<CR>", opt("[telescope] Find Buffers"))
end

kb.conform = function(module)
	map("n", "<leader>fm", function()
		vim.notify("Formatting code...")
		module.format({
			lsp_fallback = true,
			async = false,
			timeout_ms = 5000,
		})
		vim.notify("Formatting code...\nDone.")
	end, opt("[conform] Format Code"))
end

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

kb.lspsaga = function()
	map("n", "<leader>fd", function()
		vim.cmd("Lspsaga finder")
	end, opt("[lspsaga] Show All Def & Ref"))
	map("n", "<leader>gic", function()
		vim.cmd("Lspsaga incoming_calls")
	end, opt("[lspsaga] Show In Calls"))
	map("n", "<leader>goc", function()
		vim.cmd("Lspsaga outgoing_calls")
	end, opt("[lspsaga] Show Out Calls"))
	map("n", "<leader>ca", function()
		vim.cmd("Lspsaga code_action")
	end, opt("[lspsaga] Code Action"))
	map("n", "<leader>rn", function()
		vim.cmd("Lspsaga rename")
	end, opt("[lspsaga] Renam"))
	map("n", "<leader>gd", function()
		vim.cmd("Lspsaga peek_definition")
	end, opt("[lspsaga] Show Def"))
	map("n", "gO", function()
		vim.cmd("Lspsaga show_line_diagnostics")
	end, opt("[lspsaga] Show Diag Line"))
	map("n", "go", function()
		vim.cmd("Lspsaga show_cursor_diagnostics")
	end, opt("[lspsaga] Show Diag Cur"))
	map("n", "gp", function()
		vim.cmd("Lspsaga diagnostic_jump_prev")
	end, opt("[lspsaga] Show Diag Prev"))
	map("n", "gn", function()
		vim.cmd("Lspsaga diagnostic_jump_next")
	end, opt("[lspsaga] Show Diag Next"))
	map("n", "<leader>o", function()
		vim.cmd("Lspsaga outline")
	end, opt("[lspsaga] Toggle Outline"))
	map("n", "K", function()
		vim.cmd("Lspsaga hover_doc")
	end, opt("[lspsaga] Hover Doc"))
end

kb.vimtex = function()
	-- map("n", "<leader>lS", "<Plug>(vimtex-env-delete)", opt("[VimTex] Del Env Tag"))
	-- map("n", "<leader>lA", "<Plug>(vimtex-env-change)", opt("[VimTex] ALt Env Tag"))
	-- map("n", "", "<Plug>（vimtex-cmd-delete）", opt("[VimTex] Del Surround Tag"))
end

return kb
