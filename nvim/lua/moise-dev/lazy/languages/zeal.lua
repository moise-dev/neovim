-- Integrate Zeal offline documentation lookup through zeal.nvim.
return {
	"paradoxical-dev/zeal.nvim",
	event = "VeryLazy",
	cmd = {
		"Zeal",
		"ZealToggle",
		"ZealSearchFt",
		"ZealDownload",
		"ZealRemove",
		"ZealManager",
	},
	keys = {
		{
			"<leader>zs",
			function()
				require("zeal").search()
			end,
			desc = "Search Zeal docs",
		},
		{
			"<leader>zw",
			function()
				require("zeal").search_ft(vim.fn.expand("<cword>"))
			end,
			desc = "Search Zeal docs for word",
		},
		{
			"<leader>zt",
			"<cmd>ZealToggle<cr>",
			desc = "Toggle Zeal terminal",
		},
		{
			"<leader>zm",
			function()
				require("zeal").manager()
			end,
			desc = "Manage Zeal docsets",
		},
		{
			"<leader>zd",
			"<cmd>ZealDownload<cr>",
			desc = "Download Zeal docset",
		},
		{
			"<leader>zr",
			"<cmd>ZealRemove<cr>",
			desc = "Remove Zeal docset",
		},
	},
	opts = {
		browser = { "w3m", "-o", "display_image=FALSE" },
		ft_map = {
			bash = { "Bash" },
			c = { "C" },
			css = { "CSS" },
			dockerfile = { "Docker" },
			go = { "Go" },
			javascript = { "JavaScript" },
			lua = { "Lua_5.5" },
			python = { "Python_3", "pytest_Contrib", "polars_Contrib", "more_itertools_Contrib" },
			sh = { "Bash" },
			typescript = { "TypeScript" },
			zsh = { "Bash" },
		},
	},
}
