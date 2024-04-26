-- Navigate through panes using ALT + WASD.
vim.keymap.set("n", "<M-w>", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<M-a>", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<M-s>", "<cmd>wincmd j<CR>")
vim.keymap.set("n", "<M-d>", "<cmd>wincmd l<CR>")
vim.keymap.set("i", "<M-w>", "<cmd>wincmd k<CR>")
vim.keymap.set("i", "<M-a>", "<cmd>wincmd h<CR>")
vim.keymap.set("i", "<M-s>", "<cmd>wincmd j<CR>")
vim.keymap.set("i", "<M-d>", "<cmd>wincmd l<CR>")