return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    "nvim-telescope/telescope-ui-select.nvim",
  },
  opts = {
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown(),
      },
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("ui-select")
  end,
  -- stylua: ignore
  keys = {
    { "<leader>,",  "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
    { "<leader>:",  "<cmd>Telescope command_history<cr>",                          desc = "Command History" },
    -- find
    { '<leader>fg', "<cmd>Telescope live_grep<cr>",                                desc = "Live grep" },
    { '<leader>ff', "<cmd>Telescope find_files<cr>",                               desc = "Find file" },
    { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                                 desc = "Recent" },
    -- search
    { '<leader>s"', "<cmd>Telescope registers<cr>",                                desc = "Registers" },
    { "<leader>sa", "<cmd>Telescope autocommands<cr>",                             desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>",                desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>",                          desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<cr>",                                 desc = "Commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>",                      desc = "Document diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>",                              desc = "Workspace diagnostics" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>",                                desc = "Help Pages" },
    { "<leader>sH", "<cmd>Telescope highlights<cr>",                               desc = "Search Highlight Groups" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>",                                  desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>",                                desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>",                                    desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>",                              desc = "Options" },
    { "<leader>sR", "<cmd>Telescope resume<cr>",                                   desc = "Resume" },
  },
}
