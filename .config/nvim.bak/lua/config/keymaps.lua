-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set

keymap("n", "<leader>re", "<cmd>restart<CR>", { desc = "Restart Neovim" })

keymap("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlighting", silent = true })

keymap(
  "n",
  "<leader>rc",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<left><Left><Left>]],
  { desc = "Replace word under cursor globally" }
)

keymap({ "v", "x" }, "p", [["_dP]], { desc = "Paste without yanking" })
keymap({ "v", "x" }, "d", [["_d]], { desc = "Delete without yanking" })

keymap("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

keymap("n", "<S-h>", "_", { desc = "Go to start of line" })
keymap("n", "<S-l>", "g_", { desc = "Go to end of line" })

keymap("n", "<M-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
keymap("n", "<M-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
