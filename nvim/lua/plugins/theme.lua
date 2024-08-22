local colors = require("sam.color_palette").palette

local Plugin = { "folke/tokyonight.nvim" }

function Plugin.config()
	require("tokyonight").setup({
		style = "night",
		transparent = true,
		on_colors = function(tokyonight)
			tokyonight.bg_dark = colors.bg_dark -- Dark background
			tokyonight.bg = colors.bg -- Background for normal areas
			tokyonight.bg_highlight = colors.bg_highlight -- Background for highlighted areas
			tokyonight.bg_float = colors.bg_float -- Background for floating windows
			tokyonight.bg_sidebar = colors.bg_sidebar -- Background for sidebar
			tokyonight.bg_popup = colors.bg_popup -- Background for popup windows
		end,
		integrations = {
			cmp = true,
			gitsigns = true,
			harpoon = true,
			illuminate = true,
			indent_blankline = {
				enabled = false,
				scope_color = "sapphire",
				colored_indent_levels = false,
			},
			mason = true,
			native_lsp = { enabled = true },
			notify = true,
			nvimtree = true,
			neotree = true,
			symbols_outline = true,
			telescope = true,
			treesitter = true,
			treesitter_context = true,
		},
	})

	vim.cmd.colorscheme("tokyonight-night")

	-- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
	for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
		vim.api.nvim_set_hl(0, group, {})
	end
end

return Plugin
