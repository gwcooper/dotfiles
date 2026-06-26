local set = vim.keymap.set

set("n", "<leader>sv", ":source $MYVIMRC<CR>")

set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("preview_toggles", { clear = true }),
  pattern = { "html", "typst", "markdown" },
  callback = function(event)
    local toggle_command = {
      html = "LiveServerToggle",
      typst = "TypstPreviewToggle",
      markdown = "LivePreview start",
    }
    local toggle_string = "<CMD>" .. toggle_command[vim.bo[event.buf].filetype] .. "<cr>"
    vim.keymap.set("n", "<leader>tp", toggle_string, { desc = "Toggle live preview" })
    if vim.bo[event.buf].filetype == "typst" then
      vim.keymap.set("n", "<leader>tmp", "<CMD>LspTinymistPinMain<cr>", { desc = "Pin the mainfile for Typst-preview" })
    end
  end,
})

set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

set("n", "<leader>ut", "<CMD>Undotree<CR>")
set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
set("n", "<leader>xtd", "<cmd>Trouble todo<cr>", { desc = "To Do list (Trouble)" })
