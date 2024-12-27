return {

{
  "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
  lazy = false,
  branch = "regexp", -- This is the regexp branch, use this for the new version
  config = function()
      require("venv-selector").setup()
    end,
    keys = {
      { ",v", "<cmd>VenvSelect<cr>" },
    },
},

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
