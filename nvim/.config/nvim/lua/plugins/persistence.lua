vim.pack.add({
  { src = "https://github.com/folke/persistence.nvim" },
})

vim.opt.sessionoptions = { "buffers", "curdir", "folds", "help", "localoptions", "winpos", "winsize" }

require("persistence").setup({})
