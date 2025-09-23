-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- Navigate to end/start of the line
map({ "n", "v", "x" }, "H", "_", { noremap = true, silent = true, desc = "Navigate To Start Of The Line" })
map({ "n", "v", "x" }, "L", "$", { noremap = true, silent = true, desc = "Navigate To End Of The Line" })

-- Paste without ovewritting
map("v", "p", '"_dp', { noremap = true, silent = true })
map("v", "P", '"_dP', { noremap = true, silent = true })

-- Redo
map("n", "U", "<C-r>", { desc = "Redo" })

-- Select All
map("n", "<C-a>", "gg<S-v>G", { desc = "Select All" })

-- Yank all
map("n", "<C-y>", "ggyG", { desc = "Yank All" })
