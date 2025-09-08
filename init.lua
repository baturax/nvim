local v = vim
local o = v.opt
local g = v.g
local wo = vim.wo
local api = vim.api
local cmd = vim.cmd
local key = vim.keymap.set
local pack = v.pack
local gh="https://github.com/"

pack.add({
  { src = gh.."nvim-treesitter/nvim-treesitter",  }
})

-- Settings

o.scrolloff = 7
o.inccommand = "split"
o.incsearch = true
o.cursorline = true
o.undofile = true
o.fillchars:append(',eob: ')
o.expandtab = true
o.softtabstop = 2
o.shiftwidth = 2
o.tabstop = 2
o.mouse = ""
o.clipboard = "unnamedplus"

v.loader.enable = true

o.foldmethod = "expr"
o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
wo.relativenumber = true
g.mapleader = " "

-- Functions
--
-- Last Place
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		api.nvim_exec('silent! normal! g`"zv', false)
	end,
})
