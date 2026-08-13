vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
})
require("catppuccin").setup({
  lsp_styles = {
    underlines = {
      errors = { "undercurl" },
      hints = { "undercurl" },
      warnings = { "undercurl" },
      information = { "undercurl" },
    },
  },
  transparent_background = true,
  float = {
    transparent = true,
    solid = false,
  },
  integrations = {
    blink_cmp = true,
    cmp = true,
    flash = true,
    fidget = true,
    gitsigns = true,
    lsp_trouble = true,
    mason = true,
    mini = true,
    snacks = true,
    treesitter_context = true,
    ufo = true,
    which_key = true,
  },
})

vim.cmd.colorscheme("catppuccin-nvim")
