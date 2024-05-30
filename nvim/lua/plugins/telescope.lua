return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
			"ahmedkhalf/project.nvim",
			"olimorris/persisted.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			-- projects extension integration for telescope
			telescope.load_extension("projects")

			-- persisted extension for session management
			telescope.load_extension("persisted")

			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>gq", builtin.git_branches, {})
			vim.keymap.set("n", "<leader>gw", builtin.git_stash, {})

			vim.keymap.set("n", "<C-f>", builtin.current_buffer_fuzzy_find, {})
			vim.keymap.set("i", "<C-f>", builtin.current_buffer_fuzzy_find, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})

			require("telescope").load_extension("ui-select")
		end,
	},
}
