vim.lsp.config("gdshader_lsp", {
  cmd = {
    vim.fn.exepath("gdshader-lsp-cpp"),
    "--stdio",
  },
  filetypes = { "gdshader", "gdshaderinc" },
  root_markers = { "project.godot", ".git" },
})
vim.lsp.enable("gdshader_lsp")
