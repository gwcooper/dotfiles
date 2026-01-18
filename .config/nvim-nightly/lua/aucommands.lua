-- close some file types with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "grug-far",
    "help",
    -- "lspinfo",
    "oil",
    "nvim-undotree",
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
local augroup = vim.api.nvim_create_augroup('most_basic_build_system', { clear = false })
  vim.api.nvim_create_autocmd("PackChanged", {
    group = augroup,
    pattern = "*",
    callback = function(e)
      local p = e.data
      local run_task = (p.spec.data or {}).run
      if p.kind ~= "delete" and type(run_task) == 'function' then
        pcall(run_task, p)
      end
    end,
})
