local create_set = require("util").create_set_from_table

treeSitterInstallList = create_set({
  "bash",
  "diff",
  "json",
  "markdown",
  "markdown_inline",
  "toml",
  "vim",
  "vimdoc",
  "yaml",
})

serverList = create_set({})
debuggerList = create_set({})
testAdapterList = create_set({})

lintByFt = { ["*"] = { "cspell" } }
formatByFt = {}

completionProviders = {}
completionSources = {}
