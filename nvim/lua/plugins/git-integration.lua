return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup {
                current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            }

            -- vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
        end
    },
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gb", "<cmd>G blame<CR>")
        end
    }
}