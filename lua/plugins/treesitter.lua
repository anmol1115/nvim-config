return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = { "rust", "python", "lua", "vim", "c", "vimdoc", "query", "javascript", "go" },
			highlight = { enable = true },
			indent = { enable = true },
      autotag = { enable = true },
		})
	end,
}
