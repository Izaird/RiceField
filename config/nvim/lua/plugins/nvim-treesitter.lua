return {
	"nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},

  config = function()
    local ts = require 'nvim-treesitter'
    local languages = {
      "ini",
      "zsh",
      "editorconfig",
      "hyprlang",
      "regex",
      "json",
      "javascript",
      "typescript",
      "tsx",
      "yaml",
      "html",
      "css",
      "markdown",
      "markdown_inline",
      "bash",
      "lua",
      "vim",
      "dockerfile",
      "gitignore",
      "query",
      "vimdoc",
      "python",
      "go",
      "rust",
      "c",
      "cpp",
      "gdscript",
      "gdshader",
      "typst"
    }


    for _, language in ipairs(languages) do
      ts.install(language)
    end


    vim.api.nvim_create_autocmd('FileType', {
      pattern = languages,
      callback = function()
        vim.treesitter.start()
      end,

    })

  end,

}

