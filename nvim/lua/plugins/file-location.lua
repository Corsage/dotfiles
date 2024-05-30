return {
	"diegoulloao/nvim-file-location",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-file-location").setup({
			keymap = "<leader>L",
		})
	end,
}
