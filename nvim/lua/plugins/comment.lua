local Plugin = { "numToStr/Comment.nvim" }

Plugin.event = "BufEnter"

Plugin.dependencies = {
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
		end,
	},
}

function Plugin.config()
	---@diagnostic disable-next-line: missing-fields
	require("Comment").setup({
		pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
	})

	local ft = require("Comment.ft")
	ft.set("reason", { "//%s", "/*%s*/" })
end

return Plugin
