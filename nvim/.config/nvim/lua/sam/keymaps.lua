-- Normal Mode --
vim.keymap.set("n", "<space>", "<nop>") -- Disable Space bar since it'll be used as the leader key

-- redo
vim.keymap.set("n", "U","<C-r>")

vim.keymap.set("n", "<C-l>", vim.cmd.wincmd("l"))
vim.keymap.set("n", "<C-h>", vim.cmd.wincmd("h"))

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { silent = false })

-- Quit with leader key
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { silent = false })

-- Save and Quit with leader key
vim.keymap.set("n", "<leader>z", "<cmd>wq<cr>", { silent = false })

vim.keymap.set("n", "<leader>e", ":Oil --float<cr>", { silent = false })
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { silent = false })

vim.keymap.set("n", "<C-l>", ":bnext<CR>", { silent = false })
vim.keymap.set("n", "<C-h>", ":bprevious<CR>", { silent = false })
vim.keymap.set("n", "<C-c>", ":bwipeout<CR>", { silent = false })

-- Center buffer while navigating
vim.keymap.set("n", "<C-k>", "<C-u>zz")
vim.keymap.set("n", "<C-j>", "<C-d>zz")

-- center buffer while navigating search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "n", "Nzzzv")

-- paste without replacing paste with what you are highlighted over
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "G", "Gzz")
vim.keymap.set("n", "gg", "ggzz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "%", "%zz")
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")

-- Press 'S' for quick find/replace for the word under the cursor
vim.keymap.set("n", "S", function()
	local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end)

-- Diagnostics
-- Goto next diagnostic of any severity
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next({})
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto previous diagnostic of any severity
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev({})
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto next error diagnostic
vim.keymap.set("n", "]e", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto previous error diagnostic
vim.keymap.set("n", "[e", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto next warning diagnostic
vim.keymap.set("n", "]w", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto previous warning diagnostic
vim.keymap.set("n", "[w", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
	vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Open the diagnostic under the cursor in a float window
vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.open_float({
		border = "rounded",
	})
end)

-- Place all dignostics into a qflist
vim.keymap.set("n", "<leader>ls", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })

-- Open the qflist
vim.keymap.set("n", "<leader>lo", ":copen<cr>zz")

-- Close the qflist
vim.keymap.set("n", "<leader>lc", ":cclose<cr>zz")

-- Telescope keybinds
vim.keymap.set("n", "<leader>sb", ":Telescope buffers<cr>")
vim.keymap.set("n", "<leader>sf", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>sg", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>/", ":Telescope current_buffer_fuzzy_find<cr>")

-- Visual --
-- Disable Space bar since it'll be used as the leader key
vim.keymap.set("v", "<space>", "<nop>")

-- move blocks up and down
vim.keymap.set("n", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "K", ":m '<-2<CR>gv=gv")
