return {

  {
    "rmehri01/onenord.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      disable = {
        background = true,
        float_background = true,
      },
    },
  },
  {
    "neanias/everforest-nvim",
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "hard",
        transparent_background_level = 2,
        float_style = "dim",
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
}
