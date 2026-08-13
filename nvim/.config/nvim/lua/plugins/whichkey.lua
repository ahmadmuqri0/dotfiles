vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/folke/which-key.nvim" },
})
require("which-key").setup({
  preset = "helix",
})

require("which-key").add({
  { "<leader><tab>", group = "tab" },
  { "<leader>c",     group = "code" },
  { "<leader>f",     group = "find" },
  { "g",             group = "goto" },
  { "s",             group = "surround" },
  { "<leader>r",     group = "run" },
  { "<leader>s",     group = "search" },
  { "<leader>u",     group = "ui" },
  { "<leader>x",     group = "diagnostics/quickfix" },
  { "<leader>w",     group = "windows",             proxy = "<C-w>" },
  {
    "<leader>b",
    group = "buffers",
    expand = function()
      return require("which-key.extras").expand.buf()
    end,
  },
})
