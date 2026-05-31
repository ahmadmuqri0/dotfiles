vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
})
local function folder()
  local cwd = vim.fn.getcwd()
  return cwd:match("([^/]+)$")
end

local icons = require('utils.icons')

local symbols = require("trouble").statusline({
  mode = "symbols",
  groups = {},
  title = false,
  filter = { range = true },
  format = "{kind_icon}{symbol.name:Normal}",
  hl_group = "lualine_c_normal",
})

require("lualine").setup({
  options = {
    theme = "auto",
    section_separators = { left = "", right = "" },
    disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diagnostics" },
    lualine_c = {
      {
        folder,
        color = { gui = "bold" },
        separator = "/",
        padding = { left = 1, right = 0 }
      },
      { "filename", path = 1, padding = { left = 0, right = 1 } },
      -- stylua: ignore
      {
        symbols and symbols.get,
        cond = symbols.has
      }
    },
    lualine_x = {
      Snacks.profiler.status(),
      -- stylua: ignore
      {
        function() return "  " .. require("dap").status() end,
        cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
        color = function() return { fg = Snacks.util.color("Debug") } end,
      },
      {
        "diff",
        symbols = {
          added = icons.git.added,
          modified = icons.git.modified,
          removed = icons.git.removed,
        },
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,
      },
      "encoding",
      "filetype",
    },
    lualine_y = {
      {
        "progress",
        separator = " ",
        padding = { left = 1, right = 0 }
      },
      { "location", padding = { left = 0, right = 1 } },
    },
    lualine_z = {
      function()
        return " " .. os.date("%R")
      end,
    },
  },
  extensions = { "man", "mason", "quickfix" },
})
