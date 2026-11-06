--- @param x string
--- @return string
local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add({
  -- UI
  { src = gh('Shatur/neovim-ayu') },
  { src = gh('folke/snacks.nvim') },
  { src = gh('nvim-mini/mini.icons') },
  { src = gh('folke/trouble.nvim') },
  { src = gh('nvim-lualine/lualine.nvim') },
  { src = gh('akinsho/bufferline.nvim') },
  { src = gh('rachartier/tiny-cmdline.nvim') },
  -- Editor
  { src = gh('folke/which-key.nvim') },
  { src = gh('nvim-treesitter/nvim-treesitter') },
  { src = gh('saghen/blink.cmp'), version = vim.version.range('^1') },
  { src = gh('nvim-mini/mini.pairs') },
  { src = gh('jake-stewart/multicursor.nvim'), version = '1.0' },
  { src = gh('folke/todo-comments.nvim') },
  { src = gh('lewis6991/gitsigns.nvim') },
  { src = gh('linrongbin16/gitlinker.nvim') },
  { src = gh('stevearc/conform.nvim') },
  -- LSP
  { src = gh('neovim/nvim-lspconfig') },
  -- Util
  { src = gh('stevearc/oil.nvim') },
})

require('artemis.plugins.ui')
require('artemis.plugins.treesitter')
require('artemis.plugins.editor')
require('artemis.plugins.lsp')
require('artemis.plugins.util')
require('artemis.plugins.keymaps')
