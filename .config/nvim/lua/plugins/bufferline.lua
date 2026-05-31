vim.pack.add({
  { src = "https://github.com/akinsho/bufferline.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})
require('bufferline').setup({
  options = {
    -- stylua: ignore
    close_command = function(n) Snacks.bufdelete(n) end,
    -- stylua: ignore
    right_mouse_command = function(n) Snacks.bufdelete(n) end,
    diagnostics = "nvim_lsp",
    always_show_bufferline = false,
    diagnostics_indicator = function(_, _, diag)
      local icons = require('utils.icons').diagnostics
      local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
      return vim.trim(ret)
    end,
    offsets = {
      {
        filetype = "neo-tree",
        text = "Neo-tree",
        highlight = "Directory",
        text_align = "left",
      },
      {
        filetype = "snacks_layout_box",
      },
    },
  },
})

vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
  callback = function()
    vim.schedule(function()
      pcall(nvim_bufferline)
    end)
  end,
})

local keymap = vim.keymap.set

keymap("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
keymap("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
keymap("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
keymap("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
keymap("n", "<M-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
keymap("n", "<M-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
keymap("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
keymap("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
keymap("n", "[B", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer prev" })
keymap("n", "]B", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer next" })
keymap("n", "<leader>bj", "<cmd>BufferLinePick<cr>", { desc = "Pick Buffer" })
