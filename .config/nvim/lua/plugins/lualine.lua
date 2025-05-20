return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "meuter/lualine-so-fancy.nvim",
  },
  config = function(_, opts)
    opts.options = {
      theme = "catppuccin",
      component_separators = { left = "│", right = "│" },
      section_separators = { left = "", right = "" },
      globalstatus = true,
      refresh = {
        statusline = 100,
      },
    }

    local function get_venv(variable)
      local venv = os.getenv(variable)
      if venv ~= nil and string.find(venv, "/") then
        local orig_venv = venv
        for w in orig_venv:gmatch("([^/]+)") do
          venv = w
        end
        venv = string.format("%s", venv)
      end
      return venv
    end

    opts.sections = {
      lualine_a = {
        { "fancy_mode", width = 3 },
      },
      lualine_b = {
        { "fancy_branch" },
        { "fancy_diff" },
      },
      lualine_c = {
        { "fancy_cwd", substitute_home = true },
      },
      lualine_x = {
        { "fancy_macro" },
        { "fancy_diagnostics" },
        { "fancy_searchcount" },
        { "fancy_location" },
      },
      lualine_y = { { "fancy_filetype", ts_icon = "" } },
      lualine_z = {
        { "fancy_lsp_servers" },
      },
    }

    table.insert(opts.sections.lualine_y, 1, {
      function()
        local venv = get_venv("VIRTUAL_ENV") or "NO ENV"
        return " " .. venv
      end,
      cond = function()
        return vim.bo.filetype == "python"
      end,
    })
    require("lualine").setup(opts)
  end,
}
