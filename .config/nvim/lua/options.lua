local opt = vim.opt

vim.g.have_nerd_font = true

-- nvim-tree config - disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- search
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- cursor line
opt.cursorline = false

-- appearance
opt.termguicolors = true
opt.scrolloff = 8
opt.background = "dark"
opt.showmode = false
opt.signcolumn = "yes"
opt.number = true
opt.relativenumber = true
opt.inccommand = "split"
opt.winborder = "rounded"

-- editor behaviour
opt.backspace = "indent,eol,start"
opt.clipboard = "unnamedplus"
opt.confirm = true
opt.undofile = true
opt.conceallevel = 1
opt.mouse = "a"
opt.breakindent = true
-- vim.opt.smarttab = true -- Insert shiftwidth columns at the start of a line
-- vim.opt.expandtab = true -- Convert tabs to spaces
-- vim.opt.shiftwidth = 4 -- Size of an indent
-- vim.opt.tabstop = 4 -- Number of spaces a tab counts for
-- vim.opt.softtabstop = -1 -- Automatically matches the shiftwidth value

-- spelling
opt.spell = true
opt.spelllang = "en"
opt.spellsuggest = "best,8"

-- splits
opt.splitright = true
opt.splitbelow = true

-- timers
opt.updatetime = 250
opt.timeoutlen = 300

opt.completeopt = "menuone,noselect"
