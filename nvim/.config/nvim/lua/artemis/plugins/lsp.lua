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

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspInlayHints', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

vim.lsp.enable({
  'lua_ls',
  'nixd',
  'vtsls',
  'oxlint',
  'cssls',
  'tailwindcss',
  'marksman',
})
