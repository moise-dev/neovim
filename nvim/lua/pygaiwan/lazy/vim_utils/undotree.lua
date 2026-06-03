-- Configure Undotree for visualizing and navigating persistent undo history.
return {
	"mbbill/undotree",
	cmd = {
		"UndotreeFocus",
		"UndotreeHide",
		"UndotreePersistUndo",
		"UndotreeShow",
		"UndotreeToggle",
	},
	keys = {
		{ "<leader>ut", "<cmd>UndotreeToggle<CR>", desc = "[U]ndo [T]oggle", mode = "n" },
	},
	config = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>u", group = "Undo", icon = "" },
		})
	end,
}
