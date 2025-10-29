local gh = "https://github.com/"

vim.pack.add({
  { src = gh .. "saghen/blink.cmp",                 version = vim.version.range("^1") },
  { src = gh .. "mikavilpas/yazi.nvim" },
  { src = gh .. "nvim-lua/plenary.nvim" },
  { src = gh .. "akinsho/toggleterm.nvim" },
  { src = gh .. "romgrk/barbar.nvim" },
  { src = gh .. "lewis6991/gitsigns.nvim" },
  { src = gh .. "nvim-tree/nvim-web-devicons" },
  { src = gh .. "catgoose/nvim-colorizer.lua" },
  { src = gh .. "altermo/ultimate-autopair.nvim" },
  { src = gh .. "nvim-treesitter/nvim-treesitter",  version = "main" },
  { src = gh .. "HiPhish/rainbow-delimiters.nvim" },
  { src = gh .. "RRethy/vim-illuminate" },
  { src = gh .. "rcarriga/nvim-notify" },
  { src = gh .. "lukas-reineke/indent-blankline.nvim" }

})
