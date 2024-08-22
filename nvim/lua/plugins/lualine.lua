local colors = require("sam.color_palette").palette

local Plugin = { "nvim-lualine/lualine.nvim" }

Plugin.event = "VeryLazy"

Plugin.opts = {
	options = {
		theme = {
			normal = {
				a = { fg = colors.bg, bg = colors.cyan }, -- Active components
				b = { fg = colors.fg, bg = colors.bg_sidebar }, -- Inactive components
				c = { fg = colors.fg, bg = colors.bg_sidebar }, -- Inactive components
			},
			insert = { a = { fg = colors.bg, bg = colors.green } },
			visual = { a = { fg = colors.bg, bg = colors.yellow } },
			replace = { a = { fg = colors.bg, bg = colors.red } },
			command = { a = { fg = colors.bg, bg = colors.blue } },
		},
		globalstatus = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "█", right = "█" },
	},
	-- should look like below:
	-- lualine_a is skipped due to vim.opt.showmode = true
	-- NORMAL  master  nvim/lua/plugins/lualine.lua [+]           lua
	sections = {
		lualine_b = {
			{ "branch", icon = "" },
			{ "diff" },
			{ "diagnostics" },
		},
		lualine_c = {
			{ "filename", path = 1 },
		},
		lualine_x = {
			{ "filetype" },
		},
	},
	-- extensions = { "fugitive" },
}

function Plugin.init()
	vim.opt.showmode = true -- show VIM mode
end

return Plugin
