return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- require("neo-tree").setup({
      --   mappings = {
      --     ['n'] = {
      --       "add",
      --       config = {
      --         show_path = "none"
      --       }
      --     },
      --   },
      -- })

      vim.keymap.set("n", "<C-e>", ":Neotree filesystem reveal left<CR>", {})
    end
}