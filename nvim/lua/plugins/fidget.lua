local Plugin = { "j-hui/fidget.nvim" }

function Plugin.config(_, opts)
	require("fidget").setup(opts)
end

return Plugin
