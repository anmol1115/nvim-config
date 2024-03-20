return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = { "rust", "python", "lua", "vim", "c" , "vimdoc"},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
