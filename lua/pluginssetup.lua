require("blink.cmp").setup({
  appearance = {
    nerd_font_variant = "normal"
  },

  keymap = {
    preset = "super-tab"
  },

  completion = {
    documentation = {
      auto_show = true
    }
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },


  fuzzy = {
    implementation = "lua"
  }
})
vim.cmd([[colorscheme decay]])

local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup { indent = { highlight = highlight } }

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup { scope = { highlight = highlight } }

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

require('illuminate').configure({
  providers = {
    'treesitter',
    'lsp',
    'regex',
  },
})

require("nvim-treesitter").setup()
--require("nvim-treesitter").install { "go","lua"}

require("gitsigns").setup()

require("ultimate-autopair").setup()

require("colorizer").setup()

require("barbar").setup({
  animation = true,
  auto_hide = true,
  tabpages = true,
  clickable = true,
})

require("toggleterm").setup({
  shell = "fish",
  direction = "float",
  border = "curved"

})
