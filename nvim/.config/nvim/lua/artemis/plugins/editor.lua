-- Completion
---@module 'blink.cmp'
---@type blink.cmp.Config
require('blink.cmp').setup({
  snippets = {
    preset = 'default',
  },
  completion = {
    accept = {
      -- experimental auto-brackets support
      auto_brackets = {
        enabled = true,
      },
    },
    menu = {
      border = 'none',
      draw = {
        treesitter = { 'lsp' },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
    ghost_text = {
      -- TODO: Specify AI completion
      enabled = vim.g.ai_cmp,
    },
  },

  -- sources = {
  --   -- adding any nvim-cmp sources here will enable them
  --   -- with blink.compat
  --   compat = {},
  --   default = { "lsp", "path", "snippets", "buffer" },
  -- },

  cmdline = {
    enabled = true,
    keymap = {
      preset = 'cmdline',
      ['<Right>'] = false,
      ['<Left>'] = false,
    },
    completion = {
      list = { selection = { preselect = false } },
      menu = {
        auto_show = function(ctx) return vim.fn.getcmdtype() == ':' end,
      },
      ghost_text = { enabled = true },
    },
  },

  keymap = {
    preset = 'enter',
    ['c-y'] = { 'select_and_accept' },
  },

  appearance = {
    kind_icons = Artemis.icons.kinds,
  },
})

require('mini.pairs').setup({
  modes = { insert = true, command = true, terminal = false },
})

require('which-key').setup({
  preset = 'helix',
  spec = {
    {
      mode = { 'n', 'x' },
      { '<leader>b', group = 'buffer', expand = function() return require('which-key.extras').expand.buf() end },
      { '<leader>c', group = 'code' },
      { '<leader>g', group = 'git' },
      { '<leader>y', group = 'yank' },
      { ';', group = 'pickers' },
      { 's', group = 'split/window' },
      { '[', group = 'prev' },
      { ']', group = 'next' },
      { 'g', group = 'goto' },
    },
  },
})

-- Multiple cursors
local mc = require('multicursor-nvim')
mc.setup()
-- While cursors exist, <Esc> re-enables them if disabled, otherwise clears them
mc.addKeymapLayer(function(layerSet)
  layerSet('n', '<esc>', function()
    if not mc.cursorsEnabled() then
      mc.enableCursors()
    else
      mc.clearCursors()
    end
  end)
end)

-- Comments
require('todo-comments').setup()

-- Git integration
require('gitsigns').setup()
require('gitlinker').setup()

-- Formatting
local oxfmtFormatter = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true }
require('conform').setup({
  default_format_opts = {
    timeout_ms = 3000,
    async = false,
    quiet = false,
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    javascript = oxfmtFormatter,
    typescript = oxfmtFormatter,
    javascriptreact = oxfmtFormatter,
    typescriptreact = oxfmtFormatter,
    json = oxfmtFormatter,
    css = oxfmtFormatter,
    html = oxfmtFormatter,
    markdown = oxfmtFormatter,
    yaml = oxfmtFormatter,
    less = oxfmtFormatter,
    scss = oxfmtFormatter,
    ['markdown.mdx'] = oxfmtFormatter,
    lua = { 'stylua' },
    sh = { 'shfmt' },
    fish = { 'fish_indent' },
  },
  formatters = {
    oxfmt = {
      -- Treat oxfmt as available only when the project has an oxfmt config
      -- (.oxfmtrc.json / .oxfmtrc.jsonc). Without it, oxfmt is skipped and the
      -- formatter list falls back to prettier.
      require_cwd = true,
    },
  },
  format_on_save = function(bufnr)
    if vim.b[bufnr].disable_autoformat then
      return
    end
    return {
      timeout_ms = 500,
      lsp_fallback = true,
    }
  end,
})
