-- Mask secret values in environment files while allowing temporary reveal.
return {
	"laytan/cloak.nvim",
	ft = "sh",
	cmd = {
		"CloakDisable",
		"CloakEnable",
		"CloakPreviewLine",
		"CloakToggle",
	},
	keys = {
		{ "<leader>cv", "<cmd>CloakPreviewLine<cr>", desc = "[C]loak [V]iew: show token at current line" },
		{ "<leader>cV", "<cmd>CloakToggle<cr>", desc = "[C]loak [V]iew all file: show all tokens" },
	},
	config = function()
		local cloak = require("cloak")
		cloak.setup({
			enabled = true,
			cloak_character = "*",
			cloak_length = 10,
			patterns = {
				{
					file_pattern = { ".env*" },
					cloak_pattern = { "=.+" },
				},
			},
		})
	end,
}
