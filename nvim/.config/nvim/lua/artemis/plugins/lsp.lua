local capabilities = {
  workspace = {
    fileOperations = {
      didRename = true,
      willRename = true,
    },
  },
}
vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(capabilities),
})

vim.lsp.enable({
  'lua_ls',
  'nixd',
  -- "eslint",
  -- "oxlint",
  -- "cssls",
  -- "vtsls",
  -- "tailwindcss",
})
