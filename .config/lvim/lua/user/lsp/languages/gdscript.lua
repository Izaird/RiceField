local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("gdscript")


local dap = require('dap')
dap.adapters.godot = {
  type = "server",
  host = '127.0.0.1',
  port = 6006,
}

