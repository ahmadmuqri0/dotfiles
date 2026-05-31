require("vim._core.ui2").enable()

vim.loader.enable()

local nvim_start_time = vim.uv.hrtime()

_G.Config = {
  nvim_start_time = nvim_start_time,
  called = {},

  -- treesitter
  use_treesitter_parser = true,
  use_nvim_treesitter = true,

  -- diffing
  use_diffview = false,
  use_codediff = true,

}
function _G.Config.add(spec)
  require("merge")(_G.Config, spec)
end

require("options")
require("keymaps")
require("autocmds")
require("diagnostics")
require("plugins")
