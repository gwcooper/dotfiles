local dap = require("dap")

-- 1. Locate the js-debug-adapter path via Mason
local mason_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"
local host_cmd = mason_path .. "/js-debug/src/dapDebugServer.js"

dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      host_cmd,
      -- NOTE that there's an issue with nvim-dap calling this if you DO NOT specify a port and the host as `127.0.0.1`
      "${port}",
      "127.0.0.1",
    },
  },
}

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    -- at a minimum, it's nice to be able to interactively pick the process
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
  }
end
