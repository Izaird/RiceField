local M = {}

local function find_godot_project_root(start_path)
  local dir = vim.fn.fnamemodify(start_path, ':p:h')
  while dir ~= '/' do
    if vim.uv.fs_stat(dir .. '/project.godot') then
      return dir
    end
    dir = vim.fn.fnamemodify(dir, ':h')
  end
  return nil
end

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local start_path = vim.fn.argv(0)
    if start_path == '' then
      start_path = vim.fn.getcwd()
    end

    local root = find_godot_project_root(start_path)
    if root then
      local pipe = root .. '/server.pipe'
      if not vim.uv.fs_stat(pipe) then
        vim.fn.serverstart(pipe)
      end
    end
  end,
})

return M
