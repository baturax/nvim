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

