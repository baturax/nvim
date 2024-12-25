return {
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
