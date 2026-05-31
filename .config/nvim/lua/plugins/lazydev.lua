vim.pack.add({
  { src = "https://github.com/folke/lazydev.nvim" },
})
require('lazydev').setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    { path = "LazyVim",            words = { "LazyVim" } },
    { path = "snacks.nvim",        words = { "Snacks" } },
    { path = "lazy.nvim",          words = { "LazyVim" } },
    { path = "nvim-lspconfig",     words = { "lspconfig.settings" } },
  },
})
