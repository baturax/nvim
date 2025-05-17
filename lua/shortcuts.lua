local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local modes = { "n", "i" }

for i = 1, 9 do
  map(modes, "<A-" .. i .. ">", "<Cmd>BufferGoto " .. i .. "<CR>", opts)
end

map(modes, "<A-w>", "<Cmd>BufferClose<CR>", opts)
vim.keymap.set("n", "<a-e>", ":Neotree toggle<CR>")
vim.keymap.set("n", "<a-s-e>", ":Telescope file_browser<CR>")

vim.keymap.set('n', '<a-Right>', '<C-w>l')
vim.keymap.set('n', '<a-Left>', '<C-w>h')
vim.keymap.set('n', '<a-Up>', '<C-w>k')
vim.keymap.set('n', '<a-Down>', '<C-w>j')

vim.keymap.set("n", "<C-Down>", "<C-e>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Up>", "<C-y>", { noremap = true, silent = true })

vim.keymap.set('n', '<A-CR>', vim.diagnostic.open_float, { desc = "Show diagnostics" })

