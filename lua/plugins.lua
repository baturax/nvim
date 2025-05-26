-- TreeSitter
require("nvim-treesitter").setup({
   ensure_installed = { "c", "vala", "bash", "lua", "fish" },
   auto_install = true,
   hightlight = {
      enabled = true
   }
})

-- meson
require("mason").setup({
   ui = {
        icons = {
            package_installed = "✓",
            package_pending = "",
            package_uninstalled = "󰳶"
        }
    }
})

-- autopair
require("ultimate-autopair").setup({})

-- NeoTree
require("neo-tree").setup({
   filesystem = {
      filtered_items = {
        visible = true,
      }
    },
    window = {
       width = 25
    }
})

-- Telescope
require("telescope").setup({
   pickers = {
      colorscheme = {
         enable_preview = true
      }
   }
})

-- Hex
require("HexEditor").setup()

-- Color
require("nvim-highlight-colors").setup({})

-- Habit
require("hardtime").setup({
   disabled_keys = {
      ["<Up>"] = false,
      ["<Down>"] = false,
      ["<Left>"] = false,
      ["<Right>"] = false,
   },
   disable_mouse = false,
})
