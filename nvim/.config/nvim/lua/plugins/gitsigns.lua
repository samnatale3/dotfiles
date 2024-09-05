local Plugin = { "lewis6991/gitsigns.nvim" }

Plugin.event = "VeryLazy"

Plugin.opts = {
	current_line_blame = true,
}

function Plugin.config(_, opts)
	require("gitsigns").setup(opts)
end

return Plugin
