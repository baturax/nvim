vim.g.mapleader = " "

local keymap = vim.keymap.set

keymap("n", "<leader>ca", function() vim.lsp.buf.code_action() end)

keymap("n", "<leader>f", function()
  vim.lsp.buf.format()
end)

-- Buffer navigation keymaps
for i = 1, 9 do
  keymap('n', '<A-' .. i .. '>', '<Cmd>BufferGoto ' .. i .. '<CR>')
end
keymap('n', '<A-0>', '<Cmd>BufferLast<CR>')

keymap('n', '<A-w>', '<Cmd>BufferClose<CR>')

keymap({ "n", "i", "t" }, "<A-q>", "<Cmd>ToggleTerm<Cr>")

keymap({ "n", "i", "t" }, "<A-e>", "<Cmd>Yazi toggle<Cr>")

keymap("n", "<Leader>w", "<cmd>w!<CR>")

keymap({ "n", "i", "t" }, "<A-Right>", "<Cmd>wincmd l<Cr>")
keymap({ "n", "i", "t" }, "<A-Left>", "<Cmd>wincmd h<Cr>")
keymap({ "n", "i", "t" }, "<A-Up>", "<Cmd>wincmd k<Cr>")
keymap({ "n", "i", "t" }, "<A-Down>", "<Cmd>wincmd j<Cr>")
