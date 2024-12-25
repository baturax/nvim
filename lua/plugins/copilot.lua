return {

{
  "giuxtaposition/blink-cmp-copilot",
},

{
   "zbirenbaum/copilot.lua",
   config = function()
    require("copilot").setup({
       suggestion = { enabled = false },
       panel = { enabled = false },
    })
  end,
},

{
   {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" }
    },
    build = "make tiktoken",
    opts = {
    },
  }
}





}
