local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without updating the registers
keymap.set('n', 'x', '"_x')
keymap.set('n', '<Leader>p', '"0p')
keymap.set('n', '<Leader>P', '"0P')
keymap.set('v', '<Leader>p', '"0p')
keymap.set('n', '<Leader>c', '"_c')
keymap.set('n', '<Leader>C', '"_C')
keymap.set('v', '<Leader>c', '"_c')
keymap.set('v', '<Leader>C', '"_C')
keymap.set('n', '<Leader>d', '"_d')
keymap.set('n', '<Leader>D', '"_D')
keymap.set('v', '<Leader>d', '"_d')
keymap.set('v', '<Leader>D', '"_D')

-- Increment/decrement
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

-- Delete a word backwards
keymap.set('n', 'dw', 'vb"_d')

-- Remove highlight search
keymap.set('n', '<Esc>', ':nohlsearch<CR>', opts)

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Disable continuations
keymap.set('n', '<Leader>o', 'o<Esc>^Da', opts)
keymap.set('n', '<Leader>O', 'O<Esc>^Da', opts)

-- Jumplist
keymap.set('n', '<C-m>', '<C-i>', opts)

-- New tab
keymap.set('n', 'te', ':tabedit<CR>')
keymap.set('n', '<tab>', ':tabnext<CR>', opts)
keymap.set('n', '<s-tab>', ':tabprev<CR>', opts)
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

keymap.set('v', '<leader>cc', ":<C-u>lua require('artemis.utils.editor').copy_as_codeblock()<CR>")

keymap.set('n', '<leader>j', function() require('artemis.utils.editor').open_package_json() end, { desc = 'Open package.json in floating window' })

keymap.set('n', '<leader>bd', function() require('artemis.utils.editor').delete_hidden_buffers() end, { desc = 'Delete hidden buffers' })

keymap.set('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = 'Move Up' })
keymap.set('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", { desc = 'Move Down' })
keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
keymap.set('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = 'Move Down' })
keymap.set('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = 'Move Up' })
