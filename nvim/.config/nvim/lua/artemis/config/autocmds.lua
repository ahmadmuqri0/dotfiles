-- Basic autocommands
local augroup = vim.api.nvim_create_augroup('UserConfig', {})

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd('InsertLeave', {
  group = augroup,
  pattern = '*',
  command = 'set nopaste',
})

-- Highlight the current line on only the active buffer
local cursorline_group = vim.api.nvim_create_augroup('CursorLine', { clear = true })
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
  group = cursorline_group,
  pattern = '*',
  command = 'setlocal cursorline',
})
vim.api.nvim_create_autocmd('WinLeave', {
  group = cursorline_group,
  pattern = '*',
  command = 'setlocal nocursorline',
})
-- Windows closed from inside another autocmd (e.g. snacks terminal/lazygit on
-- TermClose) don't trigger WinEnter, so restore the cursorline afterwards.
vim.api.nvim_create_autocmd('TermClose', {
  group = cursorline_group,
  callback = function()
    vim.schedule(function() vim.wo.cursorline = true end)
  end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  callback = function() vim.highlight.on_yank() end,
})

-- Custom filetypes
vim.filetype.add({
  extension = {
    mjml = 'html',
  },
})
