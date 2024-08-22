-- Set custom highlight groups
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#0d0e18", fg = "#a5b0d3" }) -- Background and Foreground

vim.api.nvim_create_autocmd("textyankpost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	desc = "highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 200, visual = true })
	end,
})
