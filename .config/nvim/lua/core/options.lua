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

-- -- code folding
-- opt.foldlevelstart = 99
-- opt.foldmethod = "expr"
-- opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
--
-- opt.foldenable = true
-- opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
--
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client:supports_method("textDocument/foldingRange") then
--       local win = vim.api.nvim_get_current_win()
--       vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
--     end
--   end,
-- })
--
-- FoldText = function(virtText, lnum, endLnum, width, truncate)
--   local newVirtText = {}
--   local suffix = (" 󰡏 %d "):format(endLnum - lnum)
--   local sufWidth = vim.fn.strdisplaywidth(suffix)
--   local targetWidth = width - sufWidth
--   local curWidth = 0
--   for _, chunk in ipairs(virtText) do
--     local chunkText = chunk[1]
--     local chunkWidth = vim.fn.strdisplaywidth(chunkText)
--     if targetWidth > curWidth + chunkWidth then
--       table.insert(newVirtText, chunk)
--     else
--       chunkText = truncate(chunkText, targetWidth - curWidth)
--       local hlGroup = chunk[2]
--       table.insert(newVirtText, { chunkText, hlGroup })
--       chunkWidth = vim.fn.strdisplaywidth(chunkText)
--       -- str width returned from truncate() may less than 2nd argument, need padding
--       if curWidth + chunkWidth < targetWidth then
--         suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
--       end
--       break
--     end
--     curWidth = curWidth + chunkWidth
--   end
--   table.insert(newVirtText, { suffix, "MoreMsg" })
--   return newVirtText
-- end
--
-- opt.foldtext = "v:lua.FoldText"

-- editor behaviour
opt.backspace = "indent,eol,start"
opt.clipboard = "unnamedplus"
opt.confirm = true
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
