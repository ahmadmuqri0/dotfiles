vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/folke/trouble.nvim" },
})
local trouble = require('trouble')
trouble.setup()

local keymap = vim.keymap.set

keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle focus=true<CR>", { desc = "Open Diagnostics (Trouble)" })
keymap("n", "<leader>xX", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
  { desc = "Buffer Diagnostics (Trouble)" })
keymap("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=true<cr>", { desc = "Symbols (Trouble)" })
keymap("n", "<leader>cS", "<cmd>Trouble lsp toggle focus=true<cr>",
  { desc = "LSP references/definitions/... (Trouble)" })
keymap("n", "<leader>xL", "<cmd>Trouble loclist toggle focus=true<cr>", { desc = "Location List (Trouble)" })
keymap("n", "<leader>xQ", "<cmd>Trouble qflist toggle focus=true<cr>", { desc = "Quickfix List (Trouble)" })
keymap("n", "[q", function()
    if trouble.is_open() then
      trouble.prev({ skip_groups = true, jump = true })
    else
      local ok, err = pcall(vim.cmd.cprev)
      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end
  end,
  { desc = "Previous Trouble/Quickfix Item" })
keymap("n", "]q", function()
    if trouble.is_open() then
      trouble.next({ skip_groups = true, jump = true })
    else
      local ok, err = pcall(vim.cmd.cnext)
      if not ok then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end
  end,
  { desc = "Next Trouble/Quickfix Item" })
