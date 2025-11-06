require("blink.cmp").setup({

  keymap = {
    preset = "super-tab",
  },

  appearance = {
    nerd_font_variant = "normal"
  },

  completion = {
    menu = {
      auto_show = true,
      auto_show_delay_ms = 100,
      draw = {
        treesitter = { "lsp" }
      }
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 100
    },
    ghost_text = { enabled = true },
    keyword = {
      range = "prefix",
    },
    list = {
      selection = {
        preselect = false,
        auto_insert = true
      }
    }
  },

  sources = {
    providers = {
      path = {
        opts = {
          get_cwd = function(_)
            return vim.fn.getcwd()
          end
        }
      },
      buffer = {
        opts = {
          get_bufnrs = vim.api.nvim_list_bufs
        }
      }
    },
    default = {
      "lsp", "path", "snippets", "buffer"
    },
  },

  fuzzy = {
    implementation = "rust",
  },

  signature = {
    enabled = true
  },

  cmdline = {
    keymap = { preset = 'inherit' },
    completion = { menu = { auto_show = true } },
  },

})
vim.cmd([[colorscheme decay]])

require('nvim-ts-autotag').setup({
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = true
  }
})

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

require("nvim-treesitter").setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "javascript", "typescript", "bash", "css", "editorconfig", "fish", "gitignore", "go", "gomod", "gosum", "html", "json", "kdl", "python", "rust", "scss", "toml", "tsx", "typst", "yaml" },
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
  }
})

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
