return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    table.insert(opts.spec, {
      { "<leader>r", group = "run/replace" },
    })
  end,
}
