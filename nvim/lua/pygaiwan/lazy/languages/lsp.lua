local ENSURE_INSTALLED = {
	"lua_ls",
	"pyright",
	"ts_ls",
	"biome",
	"gopls",
	"astro",
	"typos_lsp",
	"ruff",
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp",
	},

	config = function()
		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local cmp_lsp = require("cmp_nvim_lsp")

		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		cmp.setup({
			sources = { { name = "nvim_lsp" } },
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
		})

		require("mason").setup({ PATH = "append" })
		require("mason-lspconfig").setup({
			ensure_installed = ENSURE_INSTALLED,

			handlers = {
				-- default handler
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				-----------------------------------------------------------------
				-- Lua LS
				-----------------------------------------------------------------
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "bit", "vim", "it", "describe", "before_each", "after_each", "are" },
								},
								workspace = { checkThirdParty = false },
								telemetry = { enable = false },
							},
						},
					})
				end,

				-----------------------------------------------------------------
				-- TypeScript / tsserver
				-----------------------------------------------------------------
				["ts_ls"] = function()
					require("lspconfig").ts_ls.setup({
						capabilities = capabilities,
						default_config = {
							init_options = { hostInfo = "neovim" },
							cmd = { "typescript-language-server", "--stdio" },
							filetypes = {
								"javascript",
								"javascriptreact",
								"javascript.jsx",
								"typescript",
								"typescriptreact",
								"typescript.tsx",
							},
							single_file_support = true,
						},
						settings = {
							typescript = {
								format = {
									indentSize = 4,
									convertTabsToSpaces = true,
								},
							},
						},
					})
				end,

				-----------------------------------------------------------------
				-- Pyright (Python type checking)
				-----------------------------------------------------------------
				["pyright"] = function()
					require("lspconfig").pyright.setup({
						-- cmd = { "pyright-langserver", "--stdio" },
						filetypes = { "python" },
						capabilities = capabilities,
						settings = {
							pyright = {
								disableOrganizeImports = true,
							},
							python = {
								analysis = {
									ignore = { "*" }, -- Let ruff handle linting
									autoImportCompletions = true,
								},
							},
						},
					})
				end,

				-----------------------------------------------------------------
				-- Ruff (Python linting & formatting)
				-----------------------------------------------------------------
				["ruff"] = function()
					require("lspconfig").ruff.setup({
						capabilities = {
							general = {
								positionEncodings = { "utf-16" },
							},
						},
					})
				end,

				-----------------------------------------------------------------
				-- Typos LSP
				-----------------------------------------------------------------
				["typos_lsp"] = function()
					require("lspconfig").typos_lsp.setup({
						cmd = { "typos-lsp" },
						capabilities = capabilities,
						cmd_env = { RUST_LOG = "error" },
						init_options = {
							-- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
							-- Defaults to Info.
							diagnosticSeverity = "Warning",
						},
					})
				end,
			},
		})

		-------------------------------------------------------------------------
		-- Keybindings on LspAttach
		-------------------------------------------------------------------------
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				local map = function(key, func, desc)
					vim.keymap.set("n", key, func, {
						buffer = event.buf,
						desc = "LSP: " .. desc,
					})
				end

				map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
				map("gD", vim.lsp.buf.declaration, "Goto Declaration")
				map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
				map("gr", require("telescope.builtin").lsp_references, "Goto References")
				map("K", vim.lsp.buf.hover, "Hover Docs")
				map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
				map("<leader>cD", require("telescope.builtin").lsp_type_definitions, "Type Definition")
				map("<leader>rn", vim.lsp.buf.rename, "Rename")
			end,
		})

		-- Which-key grouping
		require("which-key").add({
			{ "<leader>c", group = "Code" },
		})
	end,
}
