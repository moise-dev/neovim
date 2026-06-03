-- Toggle common word pairs such as true/false and yes/no.
return {
	"nguyenvukhang/nvim-toggler",
	keys = {
		{
			"<leader>op",
			function()
				require("nvim-toggler").toggle()
			end,
			desc = "[Op]posite word replacement",
			mode = { "n", "v" },
		},
	},
	config = function()
		local toggler = require("nvim-toggler")
		toggler.setup({
			remove_default_keybinds = true,
		})
	end,
}
