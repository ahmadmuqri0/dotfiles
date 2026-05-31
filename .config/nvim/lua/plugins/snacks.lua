vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/folke/persistence.nvim" },
  { src = "https://github.com/folke/snacks.nvim" },
})
local Snacks = require("snacks")
local keymap = vim.keymap.set

Snacks.setup({
  styles = {
    notification = {
      border = "rounded",
      wo = { winblend = 0, wrap = false },
    },
    notification_history = {
      relative = "editor",
      width = 0.9,
      height = 0.9,
    },
  },
  indent = { enabled = true },
  input = { enabled = true },
  bigfile = { enabled = true },
  explorer = { enabled = true },
  statuscolumn = { enabled = true },
  picker = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  words = { enabled = true },

  dashboard = {
    enabled = true,
    preset = {
      header = [[
  █████╗ ██████╗ ████████╗███████╗███╗   ███╗██╗███████╗
 ██╔══██╗██╔══██╗╚══██╔══╝██╔════╝████╗ ████║██║██╔════╝
 ███████║██████╔╝   ██║   █████╗  ██╔████╔██║██║███████╗
 ██╔══██║██╔══██╗   ██║   ██╔══╝  ██║╚██╔╝██║██║╚════██║
 ██║  ██║██║  ██║   ██║   ███████╗██║ ╚═╝ ██║██║███████║
 ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚═╝╚══════╝]],
      keys = {
        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        {
          icon = " ",
          key = "c",
          desc = "Config",
          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
        },
        { icon = " ", key = "s", desc = "Restore Session", action = ":lua require('persistence').load()" },
        { icon = " ", key = "p", desc = "Pack UI", action = ":Pack check" },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
    },
    sections = {
      { section = "header" },
      { section = "keys",  gap = 1, padding = 1 },
      function()
        if not _G._nvim_startup_ms then
          _G._nvim_startup_ms = Config.nvim_start_time
              and string.format("%.2f", (vim.uv.hrtime() - Config.nvim_start_time) / 1e6)
              or "?"
        end
        local ms = _G._nvim_startup_ms
        local plugin_count = #vim.fn.glob(vim.fn.stdpath("data") .. "/site/pack/*/*/*", false, true)
        return {
          align = "center",
          text = {
            { "⚡ Neovim started with ", hl = "footer" },
            { tostring(plugin_count), hl = "special" },
            { " plugins in ", hl = "footer" },
            { ms .. "ms", hl = "special" },
          },
        }
      end,
    },
  },
})

-- Explorer
keymap("n", "<leader>e", function()
  Snacks.explorer.open({ hidden = true, ignored = true, exclude = { ".DS_Store" } })
end, { desc = "Explorer" })
keymap("n", "<leader>E", function()
  Snacks.explorer.reveal({ hidden = true, ignored = true })
end, { desc = "Explorer (reveal buffer)" })

-- Grep
keymap("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })

-- Search
keymap("n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
keymap("n", '<leader>s/', function() Snacks.picker.search_history() end, { desc = "Search History" })
keymap("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
keymap("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
keymap("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
keymap("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
keymap("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
keymap("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
keymap("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
keymap("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
keymap("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
keymap("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
keymap("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
keymap("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
keymap("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
keymap("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
keymap("n", "<leader>sp", function() Snacks.picker.lazy() end, { desc = "Search for Plugin Spec" })
keymap("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
keymap("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
keymap("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo History" })
keymap("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })

-- Find
keymap("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
keymap("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
  { desc = "Find Config File" })
keymap("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
keymap("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" })
keymap("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
keymap("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })

-- Buffer
keymap("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
keymap("n", "<leader>bo", function() Snacks.bufdelete.other() end, { desc = "Delete Other Buffers" })
keymap("n", "<leader>bi", function() Snacks.bufdelete.invisible() end, { desc = "Delete Invisible Buffers" })

-- LSP (via picker)
keymap("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
keymap("n", "gs", function()
  vim.cmd("split")
  vim.lsp.buf.definition()
end, { desc = "Goto Definition (split)" })
keymap("n", "gv", function()
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end, { desc = "Goto Definition (vertical split)" })
keymap("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
keymap("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "References" })
keymap("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
keymap("n", "gt", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Definition" })
-- keymap("n", "<leader>ss", function() require('aerial').snacks_picker() end, { desc = "LSP Symbols (Aerial)" })
keymap("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
keymap("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Symbols (workspace)" })
