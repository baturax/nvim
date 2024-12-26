return {

{
   'williamboman/mason.nvim',
   opts = {
      ui = {
        check_outdated_packages_on_open = true,
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },

   },
},


{
   'mong8se/actually.nvim',
   dependencies = 'stevearc/dressing.nvim',
},

{
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
},

{
   'glacambre/firenvim',
   build = ":call firenvim#install(0)"
},

{
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
  },
}



}
