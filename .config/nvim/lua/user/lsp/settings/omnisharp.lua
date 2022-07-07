-- local pid = vim.fn.getpid()
-- -- local lspconfig = require("lspconfig")
-- local omnisharp = "/home/izaird/.local/share/nvim/lsp_servers/omnisharp/omnisharp-mono/OmniSharp.exe"

return {
  use_mono = true,
  -- cmd = {"mono", omnisharp, "--languageserver", "--hostPID", tostring(pid)}
}
