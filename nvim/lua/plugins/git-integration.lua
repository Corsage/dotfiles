return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup {
                current_line_blame = true,
            }

            vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
            vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", {})
        end
    },
    {
        "tpope/vim-fugitive",
        config = function()
            -- vim.keymap.set("n", "<leader>gb", "<cmd>G blame<CR>")
        end
    },
    {
        "mikinovation/nvim-gitui",
        config = function()
            require('nvim-gitui').setup {}
        end
    }
}
