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
vim.keymap.set("n", "<A-Down>", "<C-e>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Up>", "<C-y>", { noremap = true, silent = true })
