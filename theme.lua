vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.cmd("hi Normal guifg=#FDFEFF guibg=#171717")

vim.cmd("hi Visual guibg=#656565 guifg=NONE")

vim.cmd("hi CursorLine guibg=#222222")
