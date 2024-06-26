vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

-- Movement in insert mode
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-i>', '<Esc>O', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-o>', '<Esc>A<CR>', {noremap = true})

-- Movement in command mode
vim.api.nvim_set_keymap('c', '<C-h>', '<Left>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-j>', '<Down>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-k>', '<Up>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-l>', '<Right>', {noremap = true})

-- Relative line numbering
vim.wo.relativenumber = true



-- custom plugins
vim.opt.rtp:prepend("~/.config/nvim/lua/custom-plugins/test")
vim.cmd [[
  command! -nargs=0 Remind lua require('remind').execute()
]]
vim.cmd [[
  command! -nargs=0 ExecutePicker lua require('test').executePicker()
]]
