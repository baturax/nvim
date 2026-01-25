local v = vim
local o = v.o
local opt = v.opt
local wo = v.wo

v.cmd.colorscheme("github_dark_default")
v.loader.enable()       -- exp lua loader
o.number = true         -- number
o.relativenumber = true -- relative numbers
opt.fillchars:append(",eob: ")
opt.list = true
opt.listchars:append {
	tab = "│─",
	multispace = "·",
	lead = "·",
	trail = "·",
	nbsp = "·"
}
o.wrap = true               -- word wrap
o.scrolloff = 10            -- scroll
o.termguicolors = true      -- enable better color
o.inccommand = "split"
o.cursorline = true         -- currrent line
o.cursorlineopt = "number"  -- number as currentline
o.breakindent = true        -- same space as first
o.undofile = true           -- save history
o.mousemodel = "extend"     -- mouse
o.swapfile = true           -- rescue file
o.numberwidth = 1           -- short space between texts and line numbers
o.clipboard = "unnamedplus" -- clipboard
opt.splitright = true       -- split right
opt.splitbelow = true       -- split bottom
o.winborder = "rounded"     -- rounded borders
o.showmatch = true          -- when inserted bracket, show its matching
o.shell = "fish"            -- set shell as fish
o.foldenable = true         -- enable folding
o.foldlevel = 99            -- fold level
o.foldmethod = "expr"       -- fold method
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
wo.foldexpr = " v:lua.vim.treesitter.foldexpr()"
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

v.o.expandtab = false
v.o.tabstop = 2
v.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.diagnostic.config({ virtual_text = true, virtual_lines = true })

vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "size"

vim.g.mapleader = " "
