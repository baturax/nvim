vim.lsp.enable("lua_ls")
vim.lsp.enable("vala_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("bashls")
vim.lsp.enable("fish_lsp")
vim.lsp.enable("rust")
vim.lsp.enable("meson")

require("blink.cmp").setup({
   keymap = { preset = "enter" },

   appearance = {
      nerd_font_variant = "nerd"
   },

   completion = {
      documentation = {
         auto_show = true
      }
   },

   sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
   }

})
