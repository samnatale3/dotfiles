local Plugin = { "stevearc/dressing.nvim" }

function Plugin.config(_, opts)
	require("dressing").setup(opts)
end

return Plugin
