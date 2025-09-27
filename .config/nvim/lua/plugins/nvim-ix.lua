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
      completion = {
        auto_select_first = true,
        preselect = true,
      },
      attach = {
        ---Insert mode service initialization.
        ---NOTE: This is an advanced feature and is subject to breaking changes as the API is not yet stable.
        ---@type fun(): nil
        insert_mode = function()
          if vim.bo.buftype == "nofile" or vim.bo.buftype == "snacks_picker_input" or vim.bo.buftype == "prompt" then
            return
          end
          do
            local service = ix.get_completion_service({ recreate = true })
            service:register_source(ix.source.completion.github(), { group = 1 })
            service:register_source(ix.source.completion.calc(), { group = 1 })
            service:register_source(ix.source.completion.emoji(), { group = 1 })
            service:register_source(ix.source.completion.path(), { group = 10 })
            ix.source.completion.attach_lsp(service, {
              default = {
                group = 20,
                priority = 1,
              },
              servers = {},
            })
            service:register_source(ix.source.completion.buffer(), { group = 30, dedup = true })
          end
          do
            local service = ix.get_signature_help_service({ recreate = true })
            ix.source.signature_help.attach_lsp(service)
          end
        end,
        ---Cmdline mode service initialization.
        ---NOTE: This is an advanced feature and is subject to breaking changes as the API is not yet stable.
        ---@type fun(): nil
        cmdline_mode = function()
          local service = ix.get_completion_service({ recreate = true })
          if vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype()) then
            service:register_source(ix.source.completion.buffer(), { group = 1 })
          elseif vim.fn.getcmdtype() == ":" then
            service:register_source(ix.source.completion.path(), { group = 1 })
            service:register_source(ix.source.completion.cmdline(), { group = 10 })
          end
        end,
      },
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
