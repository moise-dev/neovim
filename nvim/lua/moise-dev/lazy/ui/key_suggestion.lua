-- provide UI for shortcut help
-- https://github.com/folke/which-key.nvim

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

		wk.add({
			{ "<leader>c", group = "Code" },
			{ "<leader>d", group = "Debugger" },
			{ "<leader>f", group = "File" },
			{ "<leader>l", group = "LSP" },
			{ "<leader>m", group = "Markup" },
			{ "<leader>s", group = "Search", icon = "" },
			{ "<leader>t", group = "Tests" },
			{ "<leader>v", group = "Venv", icon = "" },
		})
	end,
}
