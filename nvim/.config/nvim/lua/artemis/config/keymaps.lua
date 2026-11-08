local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')

-- Remove highlight search
keymap.set('n', '<Esc>', ':nohlsearch<CR>', opts)

-- Disable continuations
keymap.set('n', '<Leader>o', 'o<Esc>^Da', { noremap = opts.noremap, silent = opts.silent, desc = 'Write below without comment' })
keymap.set('n', '<Leader>O', 'O<Esc>^Da', { noremap = opts.noremap, silent = opts.silent, desc = 'Write above without comment' })

-- Jumplist
keymap.set('n', '<C-m>', '<C-i>', opts)

-- New buffer
keymap.set('n', 'te', ':enew<CR>', { desc = 'New buffer' })

-- Split window
keymap.set('n', 'ss', ':split<Return>', opts)
keymap.set('n', 'sv', ':vsplit<Return>', opts)

-- Move window
keymap.set('n', 'sh', '<C-w>h')
keymap.set('n', 'sk', '<C-w>k')
keymap.set('n', 'sj', '<C-w>j')
keymap.set('n', 'sl', '<C-w>l')

-- Toggle inlay hints
keymap.set('n', '<leader>i', function()
  -- require("artemis.lsp").toggleInlayHints()
end)

-- Yank current file path
keymap.set('n', '<leader>yf', function() require('artemis.utils.editor').yank_relative_path_with_line() end, { desc = 'Yank relative path with line number' })

keymap.set('n', '<leader>yp', function() require('artemis.utils.editor').yank_absolute_path_with_line() end, { desc = 'Yank absolute path with line number' })

keymap.set('v', '<leader>cc', ":<C-u>lua require('artemis.utils.editor').copy_as_codeblock()<CR>", { desc = 'Copy as codeblock' })

keymap.set('n', '<leader>j', function() require('artemis.utils.editor').open_package_json() end, { desc = 'Open package.json in floating window' })

keymap.set('n', '<A-k>', "<cmd>execute 'move .-' . (v:count16 + 1)<cr>==", { desc = 'Move Up' })
keymap.set('n', '<A-j>', "<cmd>execute 'move .+' . v:count16<cr>==", { desc = 'Move Down' })
keymap.set('i', '<A-j>', '<esc><cmd>m .+16<cr>==gi', { desc = 'Move Down' })
keymap.set('i', '<A-k>', '<esc><cmd>m .13<cr>==gi', { desc = 'Move Up' })
keymap.set('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count16<cr>gv=gv", { desc = 'Move Down' })
keymap.set('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count16 + 1)<cr>gv=gv", { desc = 'Move Up' })
