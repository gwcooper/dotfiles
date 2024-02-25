return {
  "nvim-neorg/neorg",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-neorg/neorg-telescope" },
    { "nvim-treesitter/nvim-treesitter" },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    { "hrsh7th/nvim-cmp" },
  },
  build = ":Neorg sync-parsers",
  -- tag = "*",
  lazy = true,   -- enable lazy load
  ft = "norg",   -- lazy load on file type
  cmd = "Neorg", -- lazy load on command
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},  -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
        ["core.dirman"] = {      -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/Documents/OrgNotes/notes",
              work = "~Documents/OrgNotes/work",
            },
            default_workspace = "work",
          },
        },
        ["core.highlights"] = {},
        ["core.integrations.nvim-cmp"] = {},
        ["core.integrations.telescope"] = {},
        ["core.integrations.treesitter"] = {},
        ["core.export.markdown"] = {},
        ["core.ui.calendar"] = {},
        ["core.journal"] = {
          config = {
            strategy = "flat",
            workspace = "notes",
          },
        },
        ["core.summary"] = {},
        ["core.tangle"] = {},
      },
    })
  end,
}
