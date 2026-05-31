vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim" },
})
vim.g.auto_format = true

require("conform").setup({
  format_on_save = function()
    if not vim.g.auto_format then
      return
    end
    return { timeout_ms = 5000, lsp_format = "fallback" }
  end,
  formatters_by_ft = {
    lua = { "stylua" },
    svelte = { "prettier" }
  },
  formatters = {},
})

vim.keymap.set("n", "<leader>uf", function()
  vim.g.auto_format = not vim.g.auto_format
  vim.notify("Auto-format: " .. (vim.g.auto_format and "on" or "off"))
end, { desc = "Toggle auto-format" })
