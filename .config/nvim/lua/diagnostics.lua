  -- native diagnostics
  do
    local icons = require("utils.icons").diagnostics

    vim.diagnostic.config({
      enable = true,

      virtual_lines = false,

      -- NOTE: disabled due to using the tiny-inline-diagnostic.nvim plugin
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●"
      },

      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = true,
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.Error,
          [vim.diagnostic.severity.WARN] = icons.Warn,
          [vim.diagnostic.severity.HINT] = icons.Hint,
          [vim.diagnostic.severity.INFO] = icons.Info,
        },
      },
    })
  end

  vim.keymap.set("n", "<leader>ud", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    vim.notify("Diagnostics: " .. (vim.diagnostic.is_enabled() and "on" or "off"))
  end, { desc = "Toggle diagnostics", silent = true })
