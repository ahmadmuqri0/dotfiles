-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Restart
vim.keymap.set("n", "<leader>re", "<cmd>restart<CR>", { desc = "Restart Neovim" })

vim.keymap.set(
  "n",
  "<leader>rc",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<left><Left><Left>]],
  { desc = "Replace word under cursor globally" }
)

vim.keymap.set("n", "u", "<cmd>silent undo<CR>", { desc = "Silently undo" })
vim.keymap.set("n", "<C-r>", "<cmd>silent redo<CR>", { desc = "Silently redo" })

vim.keymap.set("n", "<M-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<M-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
