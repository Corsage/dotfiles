-- Navigate through panes using ALT + WASD.
vim.keymap.set("n", "<M-w>", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<M-a>", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<M-s>", "<cmd>wincmd j<CR>")
vim.keymap.set("n", "<M-d>", "<cmd>wincmd l<CR>")
vim.keymap.set("i", "<M-w>", "<cmd>wincmd k<CR>")
vim.keymap.set("i", "<M-a>", "<cmd>wincmd h<CR>")
vim.keymap.set("i", "<M-s>", "<cmd>wincmd j<CR>")
vim.keymap.set("i", "<M-d>", "<cmd>wincmd l<CR>")

-- Split pane horizontally and vertically.
vim.keymap.set("n", "<M-h>", "<cmd>split<CR>")
vim.keymap.set("n", "<M-v>", "<cmd>vsplit<CR>")
vim.keymap.set("i", "<M-h>", "<cmd>split<CR>")
vim.keymap.set("i", "<M-v>", "<cmd>vsplit<CR>")

-- Close a pane.
vim.keymap.set("n", "<M-q>", "<cmd>close<CR>")
vim.keymap.set("i", "<M-q>", "<cmd>close<CR>")

-- Quit.
vim.keymap.set("n", "<C-q>", "<cmd>quit<CR>")

-- Save a file.
vim.keymap.set("n", "<C-s>", "<cmd>update<CR>")
vim.keymap.set("i", "<C-s>", "<cmd>update<CR>")

-- Cut, copy, and paste.
vim.keymap.set("n", "<C-x>", '"+x')
vim.keymap.set("i", "<C-x>", '"+x')

vim.keymap.set("n", "<C-c>", '"+y')
vim.keymap.set("i", "<C-c>", '"+y')

vim.keymap.set("i", "<C-v>", '"+p')
vim.keymap.set("n", "<C-v>", '"+p')

-- Undo and redo.
vim.keymap.set("n", "<C-z>", "<cmd>undo<CR>")
vim.keymap.set("i", "<C-z>", "<cmd>undo<CR>")

vim.keymap.set("n", "<S-z>", "<cmd>redo<CR>")
vim.keymap.set("i", "<S-z>", "<cmd>redo<CR>")

-- Command palette.
vim.keymap.set("n", "<C-P>", ":")

-- Insert mode.
vim.keymap.set("n", "`", "i")
