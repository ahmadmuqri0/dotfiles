return {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "Diagnostics (Trouble)" },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=true<cr>", desc = "Symbols (Trouble)" },
    { "<leader>cS", "<cmd>Trouble lsp toggle focus=true<cr>", desc = "LSP references/definitions/... (Trouble)" },
    { "<leader>xL", "<cmd>Trouble loclist toggle focus=true<cr>", desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle focus=true<cr>", desc = "Quickfix List (Trouble)" },
  },
}
