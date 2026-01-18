local add = vim.pack.add
local gh = function(x) return "https://github.com/" .. x end

-- Appearance --

add({{
  src = gh("catppuccin/nvim"),
  name = "catppuccin",
}})

require("catppuccin").setup({
    float = { transparent = true },
    flavour = "macchiato",
    term_colors = true,
    transparent_background = true,
    integrations = {
      dap = true,
      dap_ui = true,
      fidget = true,
      gitsigns = true,
      grug_far = true,
      lsp_trouble = true,
      markview = true,
      mason = true,
      mini = {
        enabled = true,
        indentscope_color = "", -- catppuccin color (eg. `lavender`) Default: text
      },
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
        inlay_hints = {
          background = true,
        },
      },
      neotest = true,
      noice = true,
      notify = true,
      snacks = {
        enabled = true,
        indent_scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
      },
      treesitter = true,
      treesitter_context = true,
      which_key = false,
    },
    styles = {
      keywords = { "italic" },q
    },
  })

-- Editor --
add(
	{
		gh("MagicDuck/grug-far.nvim"),
		gh("tzachar/local-highlight.nvim"),
                gh("chrisgrieser/nvim-origami"),
                gh("luukvbaal/statuscol.nvim"),
                {
			src = gh("nvim-treesitter/nvim-treesitter"),
			version = "main",
			data = {
				run = function(_)
					vim.cmd 'TSUpdate'
				end,
			},
		}, 
		gh("stevearc/oil.nvim"),
		gh("tpope/vim-sleuth"),
                gh("karb94/neoscroll.nvim"),
              }
)

vim.keymap.set({'n', 'v'}, '<leader>sr', function()
  local grug = require("grug-far")
  local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
  grug.open({
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= "" and "*." .. ext or nil,
    },
  })
end,
{desc = "Search and Replace"})

require("local-highlight").setup({animate={enabled=false}})

require("neoscroll").setup()

require("nvim-treesitter").setup()
require("nvim-treesitter").install({
  "bash",
  "beancount",
  "diff",
  "html",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "python",
  "ron",
  "rust",
  "toml",
  "typst",
  "vim",
  "vimdoc",
  "wgsl",
  "yaml"
})

require("oil").setup({ float = { max_height = 20, max_width = 100, } })
vim.keymap.set('n', "-", "<CMD>Oil --float<CR>", {desc = "Open parent directory"}) 

vim.schedule(function()
  vim.opt.foldlevel = 99
  vim.opt.foldlevelstart = 99
  vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

  require("origami").setup(
    {
      foldtext = {
        lineCount = {
          template = "󰘖%d", -- ↧
        },
      },
    })
  end
)

local builtin = require("statuscol.builtin")
require("statuscol").setup(
  {
    relculright = true,
 segments = {
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        -- {
        --   sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true },
        --   click = "v:lua.ScSa"
        -- },
        { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
        {
          sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
          click = "v:lua.ScSa"
        },
      }
      }
)

vim.cmd("packadd! nvim.undotree")
vim.api.nvim_create_autocmd("FileType", {
pattern = "nvim-undotree",
callback = function()
vim.cmd.wincmd("H")
vim.api.nvim_win_set_width(0, 40)
end,
})

vim.keymap.set('n', "<leader>tu", "<CMD>Undotree<CR>")



-- Git
add(
  {
    -- gh("APZelos/blamer.nvim"),
    gh("lewis6991/gitsigns.nvim"),
  }
)

require("gitsigns").setup()

