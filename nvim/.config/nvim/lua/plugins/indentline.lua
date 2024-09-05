local Plugin = { "lukas-reineke/indent-blankline.nvim" }

Plugin.event = "BufEnter"
Plugin.main = "ibl"

function Plugin.config()
	require("ibl").setup({
		scope = {
			enabled = false,
			show_start = false,
			show_end = false,
		},
	})
end

return Plugin
