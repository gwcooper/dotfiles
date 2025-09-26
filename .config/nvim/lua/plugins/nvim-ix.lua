return {
  "hrsh7th/nvim-ix",
  dependencies = {
    "hrsh7th/nvim-cmp-kit",
  },
  config = function()
    local ix = require("ix")
    ix.setup({
      expand_setup = function(snippet_body)
        vim.snippet.expand(snippet_body)
      end,
    })

    do
      ix.charmap.set({ "i", "c", "s" }, "<C-d>", ix.action.scroll(0 + 3))
      ix.charmap.set({ "i", "c", "s" }, "<C-u>", ix.action.scroll(0 - 3))

      -- completion.
      vim.keymap.set({ "i", "c" }, "<C-n>", ix.action.completion.select_next())
      vim.keymap.set({ "i", "c" }, "<C-p>", ix.action.completion.select_prev())
      ix.charmap.set({ "i", "c" }, "<C-Space>", ix.action.completion.complete())
      ix.charmap.set({ "i", "c" }, "<C-e>", ix.action.completion.close())
      ix.charmap.set({ "c" }, "<CR>", ix.action.completion.commit_cmdline())
      ix.charmap.set({ "i" }, "<CR>", ix.action.completion.commit({ select_first = true }))
      vim.keymap.set({ "i" }, "<Down>", ix.action.completion.select_next({ no_insert = true }))
      vim.keymap.set({ "i" }, "<Up>", ix.action.completion.select_prev({ no_insert = true }))
      ix.charmap.set(
        { "i" },
        "<C-y>",
        ix.action.completion.commit({
          select_first = true,
          replace = true,
          no_snippet = true,
        })
      )

      -- signature_help.
      ix.charmap.set({ "i", "s" }, "<C-o>", ix.action.signature_help.trigger_or_close())
      ix.charmap.set({ "i", "s" }, "<C-j>", ix.action.signature_help.select_next())
    end
  end,
}
