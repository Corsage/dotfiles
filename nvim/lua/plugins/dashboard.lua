return {
	{
		"olimorris/persisted.nvim",
		event = "VeryLazy",
		opts = {
			autosave = false,
			-- allow multiple sessions files for a project using branches
			use_git_branch = true,
			ignored_dirs = {
				-- "~/.config/nvim",
			},
		},
	},
	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		config = function()
		-- default setup
		require("project_nvim").setup()
		end,
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = {
			"olimorris/persisted.nvim",
			"ahmedkhalf/project.nvim",
		},
		opts = function()
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = {
				"                                                    ",
				" ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
				" ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
				" ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
				" ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
				" ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
				" ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
				"                                               crsg ",
			}

			dashboard.section.buttons.val = {
				dashboard.button("n", "  New file", "<cmd>ene<CR>"),
				dashboard.button(
					"SPC q l",
					"  Restore last session",
					[[<cmd>lua require("persisted").load({ last = true })<CR>]]
				),
				dashboard.button("SPC f r", "  Recent files", "<cmd>Telescope oldfiles<CR>"),
				dashboard.button("SPC f f", "  Find file", "<cmd>Telescope find_files<CR>"),
				dashboard.button("SPC f p", "  Projects", "<cmd>Telescope projects<CR>"),
				dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<CR>"),
				dashboard.button("m", "󱌣  Mason", "<cmd>Mason<CR>"),
				dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
			}

			return dashboard
		end,
		config = function(_, dashboard)
			local alpha = require("alpha")

			vim.api.nvim_create_autocmd("User", {
				callback = function()
					local stats = require("lazy").stats()
					local ms = math.floor(stats.startuptime * 100) / 100
					dashboard.section.footer.val = "󱐌 Lazy-loaded "
						.. stats.loaded
						.. "/"
						.. stats.count
						.. " plugins in "
						.. ms
						.. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})

			alpha.setup(dashboard.opts)
		end,
	}
}

