local opt = vim.opt

opt.number = true         -- Line numbers
opt.relativenumber = true -- Relative line numbers
opt.cursorline = true     -- Highlight current line
opt.wrap = false          -- Don't wrap lines
opt.scrolloff = 10        -- Keep 10 lines above/below cursor
opt.sidescrolloff = 8     -- Keep 8 columns left/right of cursor

-- Indentation
opt.tabstop = 2        -- Tab width
opt.shiftwidth = 2     -- Indent width
opt.softtabstop = 2    -- Soft tab stop
opt.expandtab = true   -- Use spaces instead of tabs
opt.smartindent = true -- Smart auto-indenting
opt.autoindent = true  -- Copy indent from current line
opt.shiftround = true  -- Round indent

-- Search settings
opt.ignorecase = true          -- Case insensitive search
opt.smartcase = true           -- Case sensitive if uppercase in search
opt.hlsearch = false           -- Don't highlight search results
opt.incsearch = true           -- Show matches as you type
opt.grepformat = "%f:%l:%c:%m" -- Parse grep output structure (file:line:column:text)
opt.grepprg = "rg --vimgrep"   -- Use ripgrep for ultra-fast project searching

-- Visual settings
opt.termguicolors = true                        -- Enable 24-bit colors
opt.signcolumn = "yes"                          -- Always show sign column
opt.showmatch = true                            -- Highlight matching brackets
opt.matchtime = 2                               -- How long to show matching bracket
opt.cmdheight = 1                               -- Command line height
opt.wrap = false                                -- Disable line wrap
opt.winborder = "rounded"                       -- Decide the shape of floating window border
opt.showmode = false                            -- Don't show mode in command line
opt.inccommand = "split"                        -- Show command operation in a split
opt.completeopt = "menu,menuone,noselect,popup" -- completion behavior
opt.conceallevel = 2                            -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true                              -- Confirm to save changes before exiting modified buffer
opt.concealcursor = ""                          -- Don't hide cursor line markup
opt.synmaxcol = 300                             -- Syntax highlighting limit
opt.ruler = false                               -- Disable the default ruler
opt.virtualedit = "block"                       -- Allow cursor to move where there is no text in visual block mode
opt.winminwidth = 5                             -- Minimum window width
opt.list = true                                 -- Show some invisible characters (tabs...
opt.listchars = {                               -- Set fill characters for white space
  tab = "» ",
  trail = "·",
  nbsp = "␣"
}
opt.fillchars = { -- Set fill characters icon
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- File handling
opt.backup = false                                 -- Don't create backup files
opt.writebackup = false                            -- Don't create backup before writing
opt.swapfile = false                               -- Don't create swap files
opt.undofile = true                                -- Persistent undo
opt.undolevels = 10000                             -- Set the level of undo to be save
opt.undodir = vim.fn.stdpath("data") .. "/undodir" -- Undo directory
opt.updatetime = 250                               -- Faster completion
opt.timeoutlen = 300                               -- Lower than default (1000) to quickly trigger which-key
opt.ttimeoutlen = 0                                -- Key code timeout
opt.autoread = true                                -- Auto reload files changed outside vim
opt.autowrite = false                              -- Auto save

-- Behavior settings
opt.hidden = false                                               -- Allow hidden buffers
opt.errorbells = false                                           -- No error bells
opt.backspace = "indent,eol,start"                               -- Better backspace behavior
opt.formatoptions =
"jcroqlnt"                                                       -- Auto-wrap text/comments, smart list alignment, clean joins
opt.jumpoptions =
"view"                                                           -- Restore original scroll position when jumping back/forward
opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- Hide welcome screen and repetitive build/completion messages
opt.conceallevel = 2                                             -- Hide markup syntax (like Markdown symbols) for a cleaner visual look
opt.confirm = true                                               -- Enable confirm dialog before executing
opt.autochdir = false                                            -- Don't auto change directory
opt.smoothscroll = true                                          -- Enable smoothscroll
opt.path:append("**")                                            -- include subdirectories in search
opt.isfname:append("@-@")                                        -- include @ in filename or path
-- opt.iskeyword:append("-")                               -- Treat dash as part of word
opt.mouse = "a"                                                  -- Enable mouse support
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"          -- Sync with system clipboard
opt.modifiable = true                                            -- Allow buffer modifications
opt.encoding = "UTF-8"                                           -- Set encoding

-- Fold settings
opt.foldenable = true        -- Enable fold
vim.wo.foldmethod = "manual" -- Set fold method as manual (ufo will takeover)
opt.foldlevel = 99           -- Start with all folds open
opt.foldcolumn = "0"         -- Fold column visibility

-- Split behavior
opt.splitbelow = true -- Horizontal splits go below
opt.splitright = true -- Vertical splits go right
opt.splitkeep = "screen"

-- Command-line completion
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- Better diff options
opt.diffopt:append("linematch:60")
