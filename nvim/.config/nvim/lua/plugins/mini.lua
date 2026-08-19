return {
  {
    "nvim-mini/mini.nvim",
    branch = "stable",
    config = function()
      require("mini.pairs").setup()
      require("mini.surround").setup()
    end,
  },
}
