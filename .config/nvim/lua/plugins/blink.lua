return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  -- use a release tag to download pre-built binaries
  version = "1.*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "default" },

    appearance = {
      nerd_font_variant = "mono",
    },

    completion = { documentation = { auto_show = true } },
    signature = { enabled = true },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
	      org = {"orgmode"}
      },
      providers = {
	      orgmode = {
		      name = 'Orgmode',
		      module = 'orgmode.org.autocompletion.blink',
		      fallbacks = { 'buffer' },
	      },
      },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
  }
}
