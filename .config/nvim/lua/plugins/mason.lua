vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/zapling/mason-lock.nvim" },
})
require("mason").setup({ PATH = "append" })

require("mason-lock").setup({
  lockfile_path = vim.fn.stdpath("config") .. "mason-lock.json",
})

require("mason-lspconfig").setup({
  automatic_enable = false,   -- we handle vim.lsp.enable() ourselves
})

local ensure_installed = {
  "lua-language-server",
  "svelte-language-server",
  "vtsls",
}

local mason_registry = require("mason-registry")
mason_registry.refresh(function()
  for _, pkg_name in ipairs(ensure_installed) do
    local ok, pkg = pcall(mason_registry.get_package, pkg_name)
    if ok and not pkg:is_installed() then
      pkg:install()
    end
  end
end)

vim.keymap.set("n", "<leader>cm", "<cmd>Mason<CR>", { desc = "Open Mason" })
