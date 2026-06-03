-- Configure Diffview for browsing Git file history and diffs.
return {
	"sindrets/diffview.nvim",
	cmd = {
		"DiffviewClose",
		"DiffviewFileHistory",
		"DiffviewFocusFiles",
		"DiffviewLog",
		"DiffviewOpen",
		"DiffviewRefresh",
		"DiffviewToggleFiles",
	},
	keys = {
		{ "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Git History", mode = "n" },
	},
}
