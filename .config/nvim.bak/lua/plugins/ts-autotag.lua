return {
  "windwp/nvim-ts-autotag",
  enabled = true,
  ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    })
  end,
}
