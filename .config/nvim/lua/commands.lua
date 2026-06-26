-- vim.pack related functions
vim.api.nvim_create_user_command("PackList", function()
  vim.pack.update(nil, { offline = true })
end, {})

vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update(nil, { offline = false })
end, {})
