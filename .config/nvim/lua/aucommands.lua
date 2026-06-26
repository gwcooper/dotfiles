-- Highlight on Yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Automated window resizing
vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("WinResize", { clear = true }),
  pattern = "*",
  command = "wincmd =",
  desc = "Auto-resize windows on terminal buffer resize.",
})

--- Move to a window (one of hjkl) or create a split if a window does not exist in the direction
--- Lua translation of:
--- https://www.reddit.com/r/vim/comments/166a3ij/comment/jyivcnl/?utm_source=share&utm_medium=web2x&context=3
--- Usage: vim.keymap("n", "<C-h>", function() move_or_create_win("h") end, {})
--
---@param key string One of h, j, k, l, a direction to move or create a split
local function smarter_win_nav(key)
  local fn = vim.fn
  local curr_win = fn.winnr()
  vim.cmd("wincmd " .. key) --> attempt to move

  if curr_win == fn.winnr() then --> didn't move, so create a split
    if key == "h" or key == "l" then
      vim.cmd("wincmd v")
    else
      vim.cmd("wincmd s")
    end

    vim.cmd("wincmd " .. key) --> move again
  end
end

-- stylelua: ignore
local key_opt = {
  {
    "n",
    "<C-h>",
    function()
      smarter_win_nav("h")
    end,
    "Move to window on the left or create a split",
  },
  {
    "n",
    "<C-j>",
    function()
      smarter_win_nav("j")
    end,
    "Move to window below or create a vertical split",
  },
  {
    "n",
    "<C-k>",
    function()
      smarter_win_nav("k")
    end,
    "Move to window above or create a vertical split",
  },
  {
    "n",
    "<C-l>",
    function()
      smarter_win_nav("l")
    end,
    "Move to window on the right or create a split",
  },
}

-- Set keybindings
for _, v in ipairs(key_opt) do
  -- non-recursive mapping, call commands silently
  local opts = { silent = true, noremap = true }
  -- Add optional description to the table if provided
  if v[4] then
    opts.desc = v[4]
  end
  -- Set keybinding
  vim.keymap.set(v[1], v[2], v[3], opts)
end

-- close some file types with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "grug-far",
    "help",
    "neotest-summary",
    "notify",
    "nvim-pack",
    "nvim-undotree",
    "oil",
    "qf",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- Build system for pack.add
local augroup = vim.api.nvim_create_augroup("most_basic_build_system", { clear = false })
vim.api.nvim_create_autocmd("PackChanged", {
  group = augroup,
  pattern = "*",
  callback = function(e)
    local p = e.data
    local run_task = (p.spec.data or {}).run
    if p.kind ~= "delete" and type(run_task) == "function" then
      pcall(run_task, p)
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    -- Replace "nofile" with the target buftype you want to disable
    if vim.bo.buftype == "nofile" then
      vim.diagnostic.enable(false, { bufnr = 0 })
    end
  end,
})
