-- Movement in insert mode
vim.api.nvim_set_keymap("i", "<C-h>", "<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<Down>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-k>", "<Up>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", { noremap = true })

-- Adding new line in insert mode
vim.api.nvim_set_keymap("i", "<C-i>", "<Esc>O", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-o>", "<Esc>A<CR>", { noremap = true })

-- Vertical motion
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true })

-- Escape in terminal Mode
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")

-- Show error message
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
