local Plugin = { "nvim-tree/nvim-tree.lua" }

local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
end

Plugin.lazy = false

Plugin.dependencies = {
	"nvim-tree/nvim-web-devicons",
}

function Plugin.config()
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

	require("nvim-tree").setup({
		on_attach = my_on_attach,
		update_focused_file = {
			enable = true,
			update_cwd = true,
		},
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
		renderer = {
			root_folder_modifier = ":t",
			icons = {
				glyphs = {
					default = "",
					symlink = "",
					folder = {
						arrow_open = "",
						arrow_closed = "",
						default = "",
						open = "",
						empty = "",
						empty_open = "",
						symlink = "",
						symlink_open = "",
					},
					git = {
						unstaged = "",
						staged = "S",
						unmerged = "",
						renamed = "➜",
						untracked = "U",
						deleted = "",
						ignored = "◌",
					},
				},
			},
		},
		diagnostics = {
			enable = true,
			show_on_dirs = true,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		view = {
			width = 30,
			side = "left",
		},
	})
end

return Plugin
