local Plugin = { "stevearc/oil.nvim" }

function Plugin.config()
	local oil = require("oil")
	oil.setup({
		view_options = {
			show_hidden = true,
		},
	})
	vim.keymap.set("n", "-", oil.toggle_float, {})
end

return Plugin
