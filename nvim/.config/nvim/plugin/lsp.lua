local servers = {
  "lua_ls",
  "nixd",
}

vim.lsp.enable(servers)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf = args.buf

    if client then
      if client.name == "lua_ls" then
        vim.lsp.codelens.enable(false, { bufnr = buf })
      end

      -- Workspace diagnostics
      if client:supports_method("workspace/diagnostic", buf) then
        vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
      end

      -- Inline completion
      if client:supports_method("textDocument/inlineCompletion", buf) then
        vim.lsp.inline_completion.enable(true)
      end

      -- Linked editing (e.g., paired HTML tags)
      if client:supports_method("textDocument/linkedEditingRange", buf) then
        vim.lsp.linked_editing_range.enable(true, { bufnr = buf })
      end

      -- Inline color swatches
      if client:supports_method("textDocument/documentColor", buf) then
        vim.lsp.document_color.enable(true, { bufnr = buf })
      end

      -- Document highlights
      if client:supports_method("textDocument/documentHighlight", buf) then
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          callback = vim.lsp.buf.clear_references,
        })
      end
    end

    -- Snacks
  end,
})

vim.api.nvim_create_autocmd("LspDetach", {
  group = vim.api.nvim_create_augroup("lsp-detach-cleanup", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    local prefix = ("nvim.lsp.%s.%d"):format(client.name, client.id)
    for namespace, metadata in pairs(vim.diagnostic.get_namespaces()) do
      local name = metadata.name or ""
      if name == prefix or vim.startswith(name, prefix .. ".") then
        vim.diagnostic.reset(namespace)
      end
    end
  end,
})
