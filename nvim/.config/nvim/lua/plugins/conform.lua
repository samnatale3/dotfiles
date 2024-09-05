local Plugin = { "stevearc/conform.nvim" }

Plugin.event = { "BufWritePre" }
Plugin.cmd = { "ConformInfo" }
Plugin.version = "0.9.*"

Plugin.opts = {
	notify_on_error = true, -- Enable notifications on formatting errors
	format_on_save = {
		lsp_fallback = true, -- Fallback to LSP if formatter is unavailable
		timeout_ms = 500, -- Timeout for formatting
	},
	formatters_by_ft = {
		javascript = { "eslint" }, -- Use eslint for JavaScript
		typescript = { "eslint" }, -- Use eslint for TypeScript
		typescriptreact = { "eslint" }, -- Use eslint for TypeScript React
		lua = { "stylua" }, -- Use stylua for Lua
	},
}

return Plugin
