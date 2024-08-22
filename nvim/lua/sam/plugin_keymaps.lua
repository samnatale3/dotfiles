local Module = {}

Module.map_lsp_keybinds = function(buffer_number)
	-- LSP keybindings
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = buffer_number })
	vim.keymap.set(
		"n",
		"<leader>ca",
		vim.lsp.buf.code_action,
		{ desc = "LSP: [C]ode [A]ction", buffer = buffer_number }
	)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition", buffer = buffer_number })

	-- Telescope LSP keybindings
	vim.keymap.set(
		"n",
		"gr",
		require("telescope.builtin").lsp_references,
		{ desc = "LSP: [G]oto [R]eferences", buffer = buffer_number }
	)
	vim.keymap.set(
		"n",
		"gi",
		require("telescope.builtin").lsp_implementations,
		{ desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number }
	)
	vim.keymap.set(
		"n",
		"<leader>bs",
		require("telescope.builtin").lsp_document_symbols,
		{ desc = "LSP: [B]uffer [S]ymbols", buffer = buffer_number }
	)
	vim.keymap.set(
		"n",
		"<leader>ps",
		require("telescope.builtin").lsp_workspace_symbols,
		{ desc = "LSP: [P]roject [S]ymbols", buffer = buffer_number }
	)

	-- Hover and signature help
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation", buffer = buffer_number })
	vim.keymap.set(
		"n",
		"<leader>k",
		vim.lsp.buf.signature_help,
		{ desc = "LSP: Signature Documentation", buffer = buffer_number }
	)
	vim.keymap.set(
		"i",
		"<C-k>",
		vim.lsp.buf.signature_help,
		{ desc = "LSP: Signature Documentation", buffer = buffer_number }
	)

	-- Lesser used LSP functionality
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration", buffer = buffer_number })
	vim.keymap.set(
		"n",
		"td",
		vim.lsp.buf.type_definition,
		{ desc = "LSP: [T]ype [D]efinition", buffer = buffer_number }
	)
end

Module.setup_cmp_keymaps = function(cmp, luasnip)
	return cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-u>"] = cmp.mapping.scroll_docs(4), -- scroll up preview
		["<C-d>"] = cmp.mapping.scroll_docs(-4), -- scroll down preview
		["<C-Space>"] = cmp.mapping.complete({}), -- show completion suggestions
		["<C-c>"] = cmp.mapping.abort(), -- close completion window
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- select suggestion
	})
end

return Module
