local gh = require("util").github_url
local set = vim.keymap.set

vim.pack.add({
  gh("mfussenegger/nvim-dap"),
  gh("rcarriga/nvim-dap-ui"),
  gh("theHamsta/nvim-dap-virtual-text"),
  gh("Carcuis/dap-breakpoints.nvim"),
  gh("Weissle/persistent-breakpoints.nvim"),
  gh("jbyuki/one-small-step-for-vimkind"),
})

require("persistent-breakpoints").setup()
require("dap-breakpoints").setup()

local dap = require("dap")

-- Neovim debugging
dap.configurations.lua = { {
  type = "nlua",
  request = "attach",
  name = "attach to running Neovim instance",
} }

dap.adapters.nlua = function(callback, config)
  callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
end

vim.keymap.set("n", "<leader>dl", function()
  require("osv").launch({ port = 8086 })
end, { noremap = true })

local dapui = require("dapui")

dapui.setup({})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end

local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

local icons = {
  Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
  Breakpoint = " ",
  BreakpointCondition = " ",
  BreakpointRejected = { " ", "DiagnosticError" },
  LogPoint = ".>",
}
vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

for name, icon in pairs(icons) do
  icon = type(icon) == "table" and icon or { icon }
  sign("Dap" .. name, { text = icon[1], texthl = icon[2] or "DiagnosticInfo", linehl = icon[3], numhl = icon[3] })
end

require("nvim-dap-virtual-text").setup({})

-- Debugging
local dapbp_api = require("dap-breakpoints.api")
local dapbp_keymaps = {
  { "db", dapbp_api.toggle_breakpoint, desc = "Toggle Breakpoint" },
  { "dts", dapbp_api.set_breakpoint, desc = "Set Breakpoint" },
  { "dtc", dapbp_api.set_conditional_breakpoint, desc = "Set Conditional Breakpoint" },
  { "dth", dapbp_api.set_hit_condition_breakpoint, desc = "Set Hit Condition Breakpoint" },
  { "dtl", dapbp_api.set_log_point, desc = "Set Log Point" },
  {
    "dtL",
    function()
      dapbp_api.load_breakpoints({
        notify = "always", ---@type "always" | "never" | "on_empty" | "on_some"
      })
    end,
    desc = "Load Breakpoints",
  },
  {
    "dtS",
    function()
      dapbp_api.save_breakpoints({
        notify = "always", ---@type "always" | "never" | "on_empty" | "on_some"
      })
    end,
    desc = "Save Breakpoints",
  },
  { "dte", dapbp_api.edit_property, desc = "Edit Breakpoint Property" },
  {
    "dtE",
    function()
      dapbp_api.edit_property({ all = true })
    end,
    desc = "Edit All Breakpoint Properties",
  },
  { "dtv", dapbp_api.toggle_virtual_text, desc = "Toggle Breakpoint Virtual Text" },
  { "dtC", dapbp_api.clear_all_breakpoints, desc = "Clear All Breakpoints" },
  { "[b", dapbp_api.go_to_previous, desc = "Go to Previous Breakpoint" },
  { "]b", dapbp_api.go_to_next, desc = "Go to Next Breakpoint" },
  { "<M-b>", dapbp_api.popup_reveal, desc = "Reveal Breakpoint" },
  { "<leader>def", dapbp_api.edit_exception_filters, desc = "Edit Exception Breakpoint Filters" },
}
for _, keymap in ipairs(dapbp_keymaps) do
  set("n", keymap[1], keymap[2], { desc = keymap.desc })
end

set("n", "dc", function()
  require("dap").continue()
end, { desc = "Debugger: Continue" })

set("n", "dra", function()
  require("dap").continue({ before = get_args })
end, { desc = "Debugger: Run with args" })

set("n", "dC", function()
  require("dap").run_to_cursor()
end, { desc = "Debugger: Run to cursor" })

set("n", "<leader>dg", function()
  require("dap").goto_()
end, { desc = "Debugger: Go to line (no execute)" })

set("n", "dI", function()
  require("dap").step_into()
end, { desc = "Debugger: Step into" })

set("n", "dJ", function()
  require("dap").down()
end, { desc = "Debugger: Down" })

set("n", "dK", function()
  require("dap").up()
end, { desc = "Debugger: Up" })

set("n", "drl", function()
  require("dap").run_last()
end, { desc = "Debugger: Run last" })

set("n", "do", function()
  require("dap").step_out()
end, { desc = "Debugger: Step Out" })

set("n", "dO", function()
  require("dap").step_over()
end, { desc = "Debugger: Step Over" })

set("n", "dp", function()
  require("dap").pause()
end, { desc = "Debugger: Pause" })

set("n", "dr", function()
  require("dap").repl.toggle()
end, { desc = "Debugger: Toggle REPL" })

set("n", "ds", function()
  require("dap").session()
end, { desc = "Debugger: Session" })

set("n", "dT", function()
  require("dap").terminate()
end, { desc = "Debugger: Terminate" })

set("n", "<leader>dw", function()
  require("dap.ui.widgets").hover()
end, { desc = "Debugger: Widgets" })
