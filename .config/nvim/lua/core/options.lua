local opt = vim.opt

-- nvim-tree config - disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- search
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = false

-- appearance
opt.termguicolors = true
opt.scrolloff = 8
opt.background = "dark"
opt.signcolumn = "yes"
opt.number = true
opt.relativenumber = true

-- editor behaviour
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.breakindent = true
opt.undofile = true
opt.conceallevel = 1

-- Fold
opt.foldenable = false
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Spell
opt.spell = true
opt.spelllang = "en"
opt.spellsuggest = "best,8"

-- window splits
opt.splitright = true
opt.splitbelow = true

-- timers
opt.updatetime = 250
opt.timeoutlen = 300

opt.completeopt = "menuone,noselect"
