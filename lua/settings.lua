vim.loader.enable()
vim.o.number = true
vim.o.relativenumber = true
vim.signcolumn = "number"
vim.opt.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.fillchars:append(",eob: ")
vim.opt.list = true
vim.o.wrap = true
vim.o.scrolloff = 10
vim.o.termguicolors = true
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.mousemodel = "extend"
vim.o.swapfile = true
vim.o.numberwidth = 1
vim.o.clipboard = "unnamedplus"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.o.winborder = "rounded"
vim.o.showmatch = true
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.shell = "fish"

vim.o.foldmethod = "expr"
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.wo.foldexpr = " v:lua.vim.treesitter.foldexpr()"
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

vim.diagnostic.config({ virtual_text = true, virtual_lines = true })

vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "size"
