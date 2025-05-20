vim.lsp.enable("lua_ls")
vim.lsp.enable("vala_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("bashls")
vim.lsp.enable("fish_lsp")
vim.lsp.enable("cssls")
vim.lsp.enable("rust-analyzer")

require("blink.cmp").setup({
   keymap = { preset = "super-tab" },

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
