return {
	"numToStr/Comment.nvim",
	lazy = false,
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			event = "VeryLazy",
		},
	},
	config = function()
		vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment" })
		vim.keymap.set("x", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment" })
		vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment" })
		vim.g.skip_ts_context_commentstring_module = true
		---@diagnostic disable: missing-fields
		require("ts_context_commentstring").setup({
			enable_autocmd = false,
		})

		-- Fallback comment strings keyed by filename pattern or extension
		local filename_commentstrings = {
			inputrc   = "# %s",
			gitconfig = "# %s",
			Makefile  = "# %s",
			makefile  = "# %s",
			hosts     = "# %s",
			fstab     = "# %s",
		}

		-- Extensions that have no filetype but should use #
		local ext_commentstrings = {
			conf  = "# %s",
			cfg   = "# %s",
			ini   = "; %s",
			toml  = "# %s",
		}

		local ts_pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

		local function pre_hook(ctx)
			-- 1. Try treesitter first
			local ok, result = pcall(ts_pre_hook, ctx)
			if ok and result then
				return result
			end

			-- 2. Fall back: check vim's detected commentstring (set by filetype plugins)
			local cs = vim.bo.commentstring
			if cs and cs ~= "" and cs ~= "/*%s*/" then
				-- only trust it if it's not the generic C default
				return cs
			end

			-- 3. Fall back: match by filename (tail only)
			local fname = vim.fn.expand("%:t") -- e.g. "inputrc", "Makefile"
			if filename_commentstrings[fname] then
				return filename_commentstrings[fname]
			end

			-- 4. Fall back: match by file extension
			local ext = vim.fn.expand("%:e") -- e.g. "conf", "cfg"
			if ext ~= "" and ext_commentstrings[ext] then
				return ext_commentstrings[ext]
			end

			-- 5. Last resort: default to #
			return "# %s"
		end

		require("Comment").setup({
			padding = true,
			sticky = true,
			toggler = {
				line  = "gcc",
				block = "gbc",
			},
			opleader = {
				line  = "gc",
				block = "gb",
			},
			extra = {
				above = "gcO",
				below = "gco",
				eol   = "gcA",
			},
			mappings = {
				basic = true,
				extra = true,
			},
			pre_hook = pre_hook,
		})
	end,
}
