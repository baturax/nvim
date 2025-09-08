local v = vim
local o = v.opt
local g = v.g
local wo = vim.wo
local api = v.api
local cmd = v.cmd
local key = v.keymap.set
local pack = v.pack
local gh = "https://github.com/"
local lsp = vim.lsp

pack.add({
  { src = gh.."nvim-treesitter/nvim-treesitter", branch="main" },
  { src = gh.."akinsho/bufferline.nvim" },
  { src = gh.."altermo/ultimate-autopair.nvim", branch='v0.6', }
})


-- Plugins
--
-- auto pair
require('ultimate-autopair').setup()
--
-- buffer
require("bufferline").setup{}

-- Lsp Config
lsp.enable("gopls")

-- tree-sitter
require("nvim-treesitter.configs").setup({
  ensure_installed = { "go", "gomod", "goctl", "gomod", "gosum", "lua" },
  sync_install = true,
  auto_install = true,
  highlight = {
    enabled = true,
  }
})

require("nvim-treesitter.install").prefer_git = true

-- Settings

o.scrolloff = 10
o.termguicolors = true
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

-- Shortcuts
local i = "i"
local n = "n"
local v = "v"
local t = "t"
key({i,n}, '<A-1>', '<Cmd>:b 1<Cr>')
key({i,n}, '<A-2>', '<Cmd>:b 2<Cr>')
key({i,n}, '<A-3>', '<Cmd>:b 3<Cr>')
key({i,n}, '<A-4>', '<Cmd>:b 4<Cr>')
key({i,n}, '<A-5>', '<Cmd>:b 5<Cr>')
key({i,n}, '<A-w>', '<Cmd>:bdel<Cr>')

-- Functions
--
-- Last Place
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		api.nvim_exec('silent! normal! g`"zv', false)
	end,
})
