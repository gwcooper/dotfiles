return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "/Users/george/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal",
      },
      {
        name = "work",
        path = "/Users/george/Library/Mobile Documents/iCloud~md~obsidian/Documents/Work Vault",
      },
    },
    daily_notes = {
      folder = "Daily Notes",
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    note_id_func = function(title)
      local sane_name = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        sane_name = title:gsub(" ", " "):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ in 1, 4 do
          sane_name = sane_name .. string.char(math.random(65, 90))
        end
      end
      return sane_name
    end,
    use_advanced_uri = true,
    open_app_foreground = false,
    finder = "telescope.nvim",
    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = "telescope.nvim",
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
    },
    attachments = {
      img_folder = "Attachments",
    },
  },
}
