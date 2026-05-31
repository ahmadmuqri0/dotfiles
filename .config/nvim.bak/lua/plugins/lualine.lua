return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options.section_separators = { left = "", right = "" }
    table.insert(opts.sections.lualine_x, { "encoding" })
    table.insert(opts.sections.lualine_x, { "filetype" })
  end,
}
