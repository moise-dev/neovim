return {
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
}
