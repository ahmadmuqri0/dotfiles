return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    opts.presets.bottom_search = false
    opts.presets.command_palette = false
    opts.presets.lsp_doc_border = true
  end,
}
