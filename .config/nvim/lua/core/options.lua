local opt = vim.opt

vim.g.loaded_python3_provider = "Users/george/.pyenv/versions/neovim/bin/python"

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
opt.undofile = true
opt.conceallevel = 1
opt.mouse = "a"
opt.breakindent = true

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
