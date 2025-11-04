return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "ConformInfo" },

	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				astro = { "biome" },
				css = { "biome" },
				html = { "biome" },
				javascript = { "biome" },
				javascriptreact = { "biome" },
				json = { "biome" },
				svelte = { "biome" },
				typescript = { "biome" },
				typescriptreact = { "biome" },
				yaml = { "biome" },
				lua = { "stylua" },
				python = { "ruff" },
			},
			format_on_save = {
				-- will fallback to lsp formatting if conform cannot do it
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},
			-- Customize formatters
			formatters = {
				ruff = {
					args = {
						"format",
						"--stdin-filename",
						"$FILENAME",
					},
					stdin = true,
				},
				biome = {
					args = {
						"format",
						"--stdin-file-path",
						"$FILENAME",
					},
					stdin = true,
				},
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>cf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "[C]ode [F]ormat" })
	end,
}
