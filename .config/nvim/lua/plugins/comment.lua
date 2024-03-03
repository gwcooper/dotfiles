return {
  "echasnovski/mini.comment",
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  event = "VeryLazy",
  opts = {
    options = {
      custom_commentstring = function()
        return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
      end,
    },
  },
  keys = {
    { "<leader>/", "<Plug>(comment_toggle_linewise_current)", "Comment line" },
    { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", "Comment line", mode = "v" },
  },
}
