local opt = vim.opt
local o = vim.o
local g=vim.g
local wo = vim.wo
local cmd = vim.cmd
g.mapleader = " "

o.tabstop = 3
o.expandtab = true
o.softtabstop = 3
o.shiftwidth = 3

opt.clipboard:append("unnamedplus")
opt.undofile = true
wo.number = true
g.loaded_netrwPlugin = 1
opt.termguicolors = true
opt.shortmess:append "sI"
opt.scrolloff = 10

cmd.aunmenu([[PopUp.How-to\ disable\ mouse]])

vim.cmd.colorscheme "mountain"
