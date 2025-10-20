return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },

  version = '1.*',
  opts = {
    keymap = {
      preset = 'default',
      ["<C-k>"] = false
    },

    appearance = {
      nerd_font_variant = 'mono'
    },

    signature = {
      enabled = true
    },

    completion = {
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },
    },
  },
}
