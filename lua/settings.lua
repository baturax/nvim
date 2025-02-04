vim.cmd.colorscheme "catppuccin-mocha"

vim.cmd.aunmenu([[PopUp.Inspect]])
vim.cmd.aunmenu([[PopUp.How-to\ disable\ mouse]])
vim.cmd.amenu([[PopUp.Code\ action <Cmd>lua vim.lsp.buf.code_action()<CR>]])
vim.cmd.amenu([[PopUp.LSP\ Hover <Cmd>lua vim.lsp.buf.hover()<CR>]])

vim.g.mapleader = " "

vim.o.tabstop = 3
vim.o.expandtab = true 
vim.o.softtabstop = 3 
vim.o.shiftwidth = 3

vim.opt.clipboard:append("unnamedplus")
vim.opt.undofile = true
vim.wo.number = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
