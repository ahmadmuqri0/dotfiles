local servers = {
  "lua_ls",
  "nixd",
}

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

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

    vim.api.nvim_create_user_command("LSPInfo", function()
      vim.cmd("checkhealth vim.lsp")
    end, { desc = "Show active LSP info" })

    local Snacks = require("snacks")
    local keymap = vim.keymap.set

    -- stylua: ignore start
    keymap("n", "K", vim.lsp.buf.hover, { buffer = buf, desc = "Hover" })
    keymap("n", "<leader>cr", vim.lsp.buf.rename, { buffer = buf, desc = "Rename" })
    keymap("n", "<leader>cR", Snacks.rename.rename_file, { buffer = buf, desc = "Rename file" })
    keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "Code action" })
    keymap("n", "<leader>cc", vim.lsp.codelens.run, { buffer = buf, desc = "Run codelens" })
    keymap({ "n", "x" }, "<M-o>", function() vim.lsp.buf.selection_range(1) end,
      { buffer = buf, desc = "Expand selection (LSP)" })
    keymap("x", "<M-i>", function() vim.lsp.buf.selection_range(-1) end,
      { buffer = buf, desc = "Shrink selection (LSP)" })
    keymap("n", "<leader>uh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end,
      { buffer = buf, desc = "Toggle inlay hints" })
    keymap("n", "<leader>ul",
      function()
        local enabled = not vim.lsp.codelens.is_enabled()
        vim.lsp.codelens.enable(enabled)
        vim.notify("Codelens: " .. (enabled and "on" or "off"))
      end, { buffer = buf, desc = "Toggle codelens" })
    keymap("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { buffer = buf, desc = "Prev diagnostic" })
    keymap("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { buffer = buf, desc = "Next diagnostic" })
    -- stylua: ignore end
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
