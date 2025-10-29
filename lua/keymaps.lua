vim.g.mapleader = " "

local keymap = vim.keymap.set

keymap("n", "<leader>ca", function() vim.lsp.buf.code_action() end)

keymap("n", "<leader>f", function()
  vim.lsp.buf.format()
end)

keymap('n', '<A-1>', '<Cmd>BufferGoto 1<CR>')
keymap('n', '<A-2>', '<Cmd>BufferGoto 2<CR>')
keymap('n', '<A-3>', '<Cmd>BufferGoto 3<CR>')
keymap('n', '<A-4>', '<Cmd>BufferGoto 4<CR>')
keymap('n', '<A-5>', '<Cmd>BufferGoto 5<CR>')
keymap('n', '<A-6>', '<Cmd>BufferGoto 6<CR>')
keymap('n', '<A-7>', '<Cmd>BufferGoto 7<CR>')
keymap('n', '<A-8>', '<Cmd>BufferGoto 8<CR>')
keymap('n', '<A-9>', '<Cmd>BufferGoto 9<CR>')
keymap('n', '<A-0>', '<Cmd>BufferLast<CR>')

keymap('n', '<A-w>', '<Cmd>BufferClose<CR>')

keymap({ "n", "i", "t" }, "<A-q>", "<Cmd>ToggleTerm<Cr>")

keymap({ "n", "i", "t" }, "<A-e>", "<Cmd>Yazi toggle<Cr>")

keymap("n", "<Leader>w", "<cmd>w!<CR>")

keymap({ "n", "i", "t" }, "<A-Right>", "<Cmd>wincmd l<Cr>")
keymap({ "n", "i", "t" }, "<A-Left>", "<Cmd>wincmd h<Cr>")
keymap({ "n", "i", "t" }, "<A-Up>", "<Cmd>wincmd k<Cr>")
keymap({ "n", "i", "t" }, "<A-Down>", "<Cmd>wincmd j<Cr>")
