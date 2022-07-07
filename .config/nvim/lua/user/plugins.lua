local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- ****Utils****************************************************************

  -- Have packer manage itself.
  use "wbthomason/packer.nvim"

  -- Useful lua functions used ny lots of plugins.
  use "nvim-lua/plenary.nvim"

  -- Autopairs, integrates with both cmp and treesitter.
  use "windwp/nvim-autopairs"

  -- Smart and Powerful commenting plugin for neovim.
  use "numToStr/Comment.nvim"

  -- A snazzy nail_care buffer line (with tabpage integration).
  use "akinsho/bufferline.nvim"

  -- Bbye allows you to do delete buffers (close files) without closing your
  -- windows or messing up your layout.
  use "moll/vim-bbye"

  -- All in one neovim plugin written in lua that provides superior project
  -- management.
  use "ahmedkhalf/project.nvim"

  -- Speed up loading Lua modules in Neovim to improve startup time.
  use "lewis6991/impatient.nvim"

  -- Adds indentation guides to all lines
  -- (including empty lines).
  use "lukas-reineke/indent-blankline.nvim"

  -- Surround selections, stylishly uwu
  use "kylechui/nvim-surround"

  -- peeks lines of the buffer in non-obtrusive way.
  use "nacro90/numb.nvim"

  -- Extended increment/decrement plugin for Neovim.
  use "monaqa/dial.nvim"

  -- A search panel for neovim.
  use "windwp/nvim-spectre"

  -- Fork from blackCauldron7/surround.nvim, a surround text object
  -- plugin for neovim.
  -- use "Mephistophiles/surround.nvim"

  -- Sniprun is a code runner plugin. It aims to provide stupidly fast
  -- partial code testing for interpreted and compiled languages.
  use {"michaelb/sniprun",
    run = "bash ./install.sh"
  }

  -- Cutlass overrides the delete operations to actually just delete and not affect
  -- the current yank.
  use "gbprod/cutlass.nvim"

  -- repeat.vim: enable repeating supported plugin maps with "."
  -- use "tpope/vim-repeat"

  -- This plugin exists for two reasons: fix neovim CursorHold and
  -- CursorHoldI autocmd events performance bug decouple updatetime
  -- from CursorHold and CursorHoldI (works for Vim and Neovim)
  -- use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight

  -- A Neovim plugin that use build-in :mksession to manage sessions
  -- like folders in VSCode. It allows you to save the current folder
  -- as a session to open it later. The plugin can also automatically
  -- load the last session on startup, save the current one on exit
  -- and switch between session folders. The plugin saves the sessions
  -- in the specified folder (see configuration). The session
  -- corresponds to the working directory. If a session already exists
  -- for the current folder, it will be overwritten.
  -- use "Shatur/neovim-session-manager"

  -- You can think of NeoZoom.lua as enhanced :tab split
  -- use { "nyngwang/NeoZoom.lua",
  --   branch = "neo-zoom-original"
  -- }

  -- Just Another Buffer Switcher is a minimal buffer switcher window
  -- for Neovim written in Lua.
  use {
    "christianchiarulli/JABS.nvim",
    requires = { "kyazdani42/nvim-web-devicons" }, --optional
  }

  -- Multicursor mimicks vscode.
  use "mg979/vim-visual-multi"


  -- ****UI***********************************************************

use {
  'kdheepak/tabline.nvim',
  requires = { { 'hoob3rt/lualine.nvim', opt=true }, {'kyazdani42/nvim-web-devicons', opt = true} }
}

  -- Neovim plugin to improve the default vim.ui interfaces
  use "stevearc/dressing.nvim"

  -- Neovim plugin that offers context when cycling buffers in the
  -- form of a customizable notification window.
  use "ghillb/cybu.nvim"

  -- Simple winbar/statusline plugin that shows your current code context
  -- use "SmiteshP/nvim-navic"
  -- use "fgheng/winbar.nvim"

  -- Status line component that shows context of the current cursor
  -- position in file. It is similar to the statusline function
  -- provided by nvim-treesitter, but smarter.
  -- use "SmiteshP/nvim-gps"

  use { "christianchiarulli/nvim-gps", branch = "text_hl" }

  -- Show register content when you try to access it in Neovim.
  use "tversteeg/registers.nvim"

  -- A fancy, configurable, notification manager for NeoVim
  use "rcarriga/nvim-notify"

  -- A lua fork of vim-devicons.
  -- This plugin provides the same icons as well as colors
  -- for each icon.
  use "kyazdani42/nvim-web-devicons"

  -- A File Explorer For Neovim Written In Lua
  use "kyazdani42/nvim-tree.lua"

  -- A simple file explorer
  use "tamago324/lir.nvim"

  -- fastk and fully customizable greeter for neovim.
  use "goolord/alpha-nvim"

  -- displays a popup with possible key bindings of the command you
  -- started typing. Heavily inspired by the original emacs-which-key
  -- and vim-which-key.
  use "folke/which-key.nvim"

  -- Distraction-free coding for Neovim >= 0.5
  use "folke/zen-mode.nvim"

  -- highlight and search for todo comments like:
  -- PERF: lorem ipsum
  -- HACK: lorem ipsum
  -- TODO: lorem ipsum
  -- NOTE: lorem ipsum
  -- FIX: lorem ipsum
  -- WARNING: lorem ipsum
  -- BUG: lorem ipsum
  -- in your code base.
  use "folke/todo-comments.nvim"

  -- A blazing fast and easy to configure Neovim statusline.
  use "nvim-lualine/lualine.nvim"

  -- A neovim plugin to persist and toggle multiple
  -- terminals during an editing session
  use "akinsho/toggleterm.nvim"

  -- A high-performance color highlighter for Neovim which has no
  -- external dependencies.
  use "norcalli/nvim-colorizer.lua"

  -- The goal of nvim-bqf is to make Neovim's quickfix
  -- window better.
  use "kevinhwang91/nvim-bqf"

  -- Preview markdown on your modern browser with synchronised
  -- scrolling and flexible configuration
  use {"iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  }

  -- An implementation of the Popup API from vim in Neovim.
  -- use "nvim-lua/popup.nvim"

  -- A bunch of colorschemes you can try out
  use "lunarvim/colorschemes"

  -- Themes
  use "rakr/vim-one"
  use "folke/tokyonight.nvim"
  use "lunarvim/darkplus.nvim"
  use "thedenisnikulin/vim-cyberpunk"
  use "rose-pine/neovim"


  -- ****Navigation***************************************************

  -- Supercharge your workflow and start tabbing out from parentheses,
  -- quotes, and similar contexts today.
  use {
    "abecodes/tabout.nvim",
    wants = { "nvim-treesitter" }, -- or require if not used so far
  }
  -- The ability to specify, or on the fly, mark and create persisting
  -- key strokes to go to the files you want. Unlimited terminals and
  -- navigation.
  use "ThePrimeagen/harpoon"

  -- This vim plugin allows toggling bookmarks per line.
  -- A quickfix window gives access to all bookmarks.
  -- Annotations can be added as well. These are special bookmarks
  -- with a comment attached. They are useful for preparing code
  -- reviews. All bookmarks will be restored on the next startup.
  use "MattesGroeger/vim-bookmarks"

  -- Neoscroll: a smooth scrolling neovim plugin.
  use "karb94/neoscroll.nvim"

  -- An always-on highlight for a unique character in every word on
  -- a line
  use "unblevable/quick-scope"

  -- EasyMotion-like plugin allowing you to jump anywhere in a
  -- document with as few keystrokes as possible.
  use "Christianchiarulli/hop.nvim"

  -- Match-up is a plugin that lets you highlight, navigate, and
  -- operate on sets of matching text. It extends vim's % key to
  -- language-specific words instead of just single characters.
  use "andymass/vim-matchup"


  -- ****LSP(Language Server Protocol)****************************************

  -- Enable LSP
  use "christianchiarulli/nvim-lspconfig"

  -- simple to use language server installer
  use "williamboman/nvim-lsp-installer"

  -- for formatters and linters
  use "jose-elias-alvarez/null-ls.nvim"

  -- A tree like view for symbols in Neovim using the LSP.
  use "simrat39/symbols-outline.nvim"

  -- Show function signature when you type
  use "ray-x/lsp_signature.nvim"

  -- A Neovim Lua plugin providing access to the SchemaStore catalog.
  use "b0o/SchemaStore.nvim"

  -- A pretty list for showing diagnostics, references, telescope results,
  -- quickfix and location lists to help you solve all the trouble your
  -- code is causing.
  use "folke/trouble.nvim"

  -- language server settings defined in json for
  -- use "tamago324/nlsp-settings.nvim"

  -- renamer.nvim is a Visual-Studio-Code-like renaming UI
  -- use "filipdutescu/renamer.nvim"

  -- GitHub Copilot is an AI pair programmer
  -- use "github/copilot.vim"

  use {"zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require "user.copilot"
      end, 100)
    end,
  }

  use {"zbirenbaum/copilot-cmp",
    module = "copilot_cmp",
  }

  -- illuminate.vim - Vim plugin for automatically highlighting other
  -- uses of the word under the cursor. Integrates with Neovim's LSP
  -- client for intelligent highlighting.
  use "RRethy/vim-illuminate"

  use "stevearc/aerial.nvim"
  use "j-hui/fidget.nvim"
  -- TODO: set this up
  use "rmagatti/goto-preview"


  -- ****CMP(Completition Plugin)*************************************

  -- The completion plugin
  use "hrsh7th/nvim-cmp"

  -- buffer completions
  use "hrsh7th/cmp-buffer"

  -- path completions
  use "hrsh7th/cmp-path"

  -- cmdline completions
  use "hrsh7th/cmp-cmdline"

  -- snippet completions
  use "saadparwaiz1/cmp_luasnip"

  -- nvim-cmp source for neovim Lua API.
  use "hrsh7th/cmp-nvim-lua"

  -- nvim-cmp source for neovim's built-in language server client.
  use "hrsh7th/cmp-nvim-lsp"

  -- nvim-cmp source for emojis.
  use "hrsh7th/cmp-emoji"

  -- Tabnine source for hrsh7th/nvim-cmp
  use {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  }

  -- ****Telescope************************************************************

  use "nvim-telescope/telescope.nvim"
  use "tom-anders/telescope-vim-bookmarks.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use "lalitmee/browse.nvim"
  -- use "nvim-telescope/telescope-ui-select.nvim"
  -- use "nvim-telescope/telescope-file-browser.nvim"


  -- ****Treesitter***********************************************************

  use "nvim-treesitter/nvim-treesitter"
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "p00f/nvim-ts-rainbow"
  use "nvim-treesitter/playground"
  use "windwp/nvim-ts-autotag"
  use "drybalka/tree-climber.nvim"


  -- ****Git******************************************************************

  use "lewis6991/gitsigns.nvim"
  use "f-person/git-blame.nvim"
  use "ruifm/gitlinker.nvim"
  use "mattn/vim-gist"
  use "mattn/webapi-vim"
  -- use "https://github.com/rhysd/conflict-marker.vim"


  -- ****DAP(Debug Adapter Protocol)******************************************

  -- use "mfussenegger/nvim-dap"
  -- use "theHamsta/nvim-dap-virtual-text"
  -- use "rcarriga/nvim-dap-ui"
  -- use "Pocco81/DAPInstall.nvim"

  -- ****Snippets*************************************************************

  -- Snippet engine
  use "L3MON4D3/LuaSnip"

  -- a bunch of snippets to use
  use "rafamadriz/friendly-snippets"

  -- React code snippets for vim
  use "epilande/vim-react-snippets"

  -- Extensions for React, React-Native and Redux in JS/TS with ES7+
  -- syntax. Customizable. Built-in integration with prettier.
  use { 'dsznajder/vscode-es7-javascript-react-snippets',
    run = 'yarn install --frozen-lockfile && yarn compile'
  }

  -- Java
  use "mfussenegger/nvim-jdtls"

  -- Rust
  use "simrat39/rust-tools.nvim"
  use "Saecki/crates.nvim"
  -- use "romgrk/nvim-treesitter-context"
  -- use "mizlan/iswap.nvim"


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
