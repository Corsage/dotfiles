return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			enable_autocmd = false,
		},
	},
	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- ts-context commentstring
			local context_commentstring_integration = require("ts_context_commentstring.integrations.comment_nvim")
			-- custom setup
			require("Comment").setup({
				-- toggle mappings in normal mode
				toggler = {
					-- line comment toggle keymap
					line = "<C-_>", -- CTRL + /
				},
				-- opleader mappings in visual mode
				opleader = {
					-- multiline comment toogle keymap
					block = "<C-_>",
				},
				-- nvim-ts-context-commentstring integration
				pre_hook = context_commentstring_integration.create_pre_hook(),
			})
		end,
	},
}
