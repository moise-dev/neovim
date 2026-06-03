-- Provide testing capabilities for languagtes. So far only python has been tested.
-- They are part of Which Key group "T"

return {
	"nvim-neotest/neotest",
	keys = {
		{
			"<leader>tr",
			function()
				require("neotest").run.run()
			end,
			desc = "Run nearest test",
		},
		{
			"<leader>tR",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run all tests in the file",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Run nearest test in debug",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle test summary",
		},
		{
			"<leader>ti",
			function()
				require("neotest").output.open()
			end,
			desc = "Open detailed output of the nearest test",
		},
	},
	dependencies = {
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-jest", -- this needs corepack (npm install corepack)
		"nvim-neotest/nvim-nio",
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local neotest = require("neotest")
		neotest.setup({
			-- not too sure about this for now is written in jest config
			discovery = {
				enabled = false,
			},
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
					args = { "--log-level", "DEBUG" },
					runner = "pytest",
					pytest_discover_instances = true,
					is_test_file = function(file_path)
						local filename = vim.fn.fnamemodify(file_path, ":t")
						return filename:match("^test_") or filename:match("_test%.py$")
					end,
				}),
				require("neotest-jest")({
					jestCommand = "npm test --",
					cwd = function(path)
						return vim.fn.getcwd()
					end,
					jest_test_discovery = false,
				}),
			},
		})

	end,
}
