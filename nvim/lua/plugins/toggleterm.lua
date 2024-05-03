return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup()
		vim.keymap.set("n", "<leader>t", "<cmd>:ToggleTerm size=10 direction=float name=main<cr>")
	end,
}
