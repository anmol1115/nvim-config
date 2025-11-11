return {
  "folke/styler.nvim",
  dependencies = {
    "folke/tokyonight.nvim", -- ensure the theme is available first
  },
  config = function()
    local styler = require("styler")

    styler.setup({
      themes = {
        terminal = { colorscheme = "tokyonight-storm" },
      },
    })

    vim.api.nvim_create_autocmd({ "TermOpen", "BufWinEnter" }, {
      callback = function(args)
        local buf = args.buf
        if vim.bo[buf].buftype == "terminal" then
          ---@diagnostic disable-next-line: param-type-mismatch
          styler.set_theme(0, { colorscheme = "tokyonight-storm", background = "dark" })
        end
      end,
    })
  end,
}
