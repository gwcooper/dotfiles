local gh = require("util").github_url

vim.pack.add({
  gh("rafamadriz/friendly-snippets"),
  gh("saghen/blink.cmp"),
  gh("saghen/blink.lib"),
})

local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
  appearance = { nerd_font_variant = "mono" },
  completion = { documentation = { auto_show = true } },
  fuzzy = { implementation = "rust" },
  keymap = { preset = "default" },
  signature = { enabled = true },
  snippets = { preset = "default" },
  sources = {
    default = function(ctx)
      local success, node = pcall(vim.treesitter.get_node)
      if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
        return { "buffer" }
      else
        return { "lsp", "path", "snippets", "buffer" }
      end
    end,
    per_filetype = _G.completionSources,
    providers = _G.completionProviders,
  },
})
