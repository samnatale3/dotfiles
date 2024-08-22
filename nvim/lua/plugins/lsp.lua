local Plugin = { "neovim/nvim-lspconfig" }

Plugin.event = { "BufReadPost" }
Plugin.cmd = { "LspInfo", "LspInstall", "LspUninstall", "Mason" }

Plugin.dependencies = {
	-- Mason plugins for installing LSPs and tools
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "WhoIsSethDaniel/mason-tool-installer.nvim" },

	-- Autocompletion for LSPs
	{ "hrsh7th/cmp-nvim-lsp" },

	-- LSP status/progress UI
	{ "j-hui/fidget.nvim", opts = {} },
}

-- Custom function to filter specific TSServer diagnostics
local function tsserver_diagnostics_filter(_, result, ctx, config)
	local messages_to_filter = {
		"This may be converted to an async function.",
		"'_Assertion' is declared but never used.",
		"'__Assertion' is declared but never used.",
		"The signature '(data: string): string' of 'atob' is deprecated.",
		"The signature '(data: string): string' of 'btoa' is deprecated.",
	}

	local filtered_diagnostics = vim.tbl_filter(function(diagnostic)
		for _, message in ipairs(messages_to_filter) do
			if diagnostic.message == message then
				return false
			end
		end
		return true
	end, result.diagnostics)

	result.diagnostics = filtered_diagnostics
	vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
end

function Plugin.config()
	local map_lsp_keybinds = require("sam.plugin_keymaps").map_lsp_keybinds

	-- LSP default handlers
	local default_handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	}

	-- LSP on_attach function
	local function on_attach(_, bufnr)
		map_lsp_keybinds(bufnr)
	end

	-- Extend default LSP capabilities with completion capabilities
	local capabilities = vim.tbl_deep_extend(
		"force",
		vim.lsp.protocol.make_client_capabilities(),
		require("cmp_nvim_lsp").default_capabilities()
	)

	-- List of LSP servers with configurations
	local servers = {
		cssls = {},
		gleam = {},
		eslint = {},
		html = {},
		jsonls = {},
		lua_ls = {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					workspace = {
						checkThirdParty = false,
						library = {
							"${3rd}/luv/library",
							unpack(vim.api.nvim_get_runtime_file("", true)),
						},
					},
					telemetry = { enabled = false },
				},
			},
		},
		nil_ls = {},
		sqlls = {},
		tailwindcss = {},
		tsserver = {
			settings = { maxTsServerMemory = 12000 },
			handlers = {
				["textDocument/publishDiagnostics"] = vim.lsp.with(tsserver_diagnostics_filter, {}),
			},
		},
		yamlls = {},
	}

	-- Formatters
	local formatters = {
		prettierd = {},
		stylua = {},
	}

	-- Exclude manually installed servers from Mason installation
	local manually_installed_servers = { "ocamllsp", "gleam" }

	-- Mason tools to install
	local mason_tools_to_install = vim.tbl_keys(vim.tbl_deep_extend("force", {}, servers, formatters))

	local ensure_installed = vim.tbl_filter(function(name)
		return not vim.tbl_contains(manually_installed_servers, name)
	end, mason_tools_to_install)

	-- Mason Tool Installer Setup
	require("mason-tool-installer").setup({
		auto_update = true,
		run_on_start = true,
		start_delay = 3000,
		debounce_hours = 12,
		ensure_installed = ensure_installed,
		automatic_installation = true,
	})

	-- Setup each LSP server with handlers and settings
	for name, config in pairs(servers) do
		require("lspconfig")[name].setup({
			capabilities = capabilities,
			filetypes = config.filetypes,
			handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
			on_attach = on_attach,
			settings = config.settings,
		})
	end

	-- Mason setup with UI options
	require("mason").setup({
		ui = { border = "rounded" },
	})

	-- Mason-LSPConfig setup to ensure specific servers are installed
	require("mason-lspconfig").setup({
		ensure_installed = { "eslint" },
	})

	-- Configure the UI for LSPInfo with rounded borders
	require("lspconfig.ui.windows").default_options.border = "rounded"

	-- ESLint LSP configuration format on save
	require("lspconfig").eslint.setup({
		on_attach = function(_, bufnr)
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				command = "EslintFixAll",
			})
		end,
	})

	-- Diagnostics UI configuration with rounded borders
	vim.diagnostic.config({
		float = { border = "rounded" },
	})
end

-- Plugin initialization function (currently unused)
function Plugin.init() end

return Plugin
