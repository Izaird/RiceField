-- ~/.config/nvim/lsp/gdshader_lsp.lua
return {
  cmd = { "gdshader-lsp" }, -- must be on your $PATH
  filetypes = { "gdshader", "gdshaderinc" },
  root_markers = { "project.godot", ".git" },
}
