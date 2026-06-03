-- Configure Zen Mode for a narrower distraction-free editing window.
return {
	"folke/zen-mode.nvim",
	cmd = "ZenMode",
	opts = {
		window = {
			width = 0.75,
		},
	},
}
