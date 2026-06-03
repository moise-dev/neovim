-- Configure nvim-dap for Python debugging and debugger navigation keymaps.
return {
	"mfussenegger/nvim-dap",
	keys = {
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Set Breakpoint",
		},
		{
			"<leader>dn",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.open()
			end,
			desc = "Open REPL",
		},
	},
	config = function()
		local dap = require("dap")

		-- Python adapter setup
		dap.adapters.python = {
			type = "executable",
			command = "python",
			args = { "-m", "debugpy.adapter" },
		}
		-- python path not needed thanks to venv-selector
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
			},
		}
	end,
}
