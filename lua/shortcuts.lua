local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local mods = {"n", "i"}

map(mods, "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
map(mods, "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
map(mods, "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
map(mods, "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
map(mods, "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
map(mods, "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
map(mods, "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
map(mods, "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
map(mods, "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)

map(mods, "<A-w>", "<Cmd>BufferClose<CR>", opts)
map(mods, "<A-e>", "<Cmd>Neotree toggle<CR>")
map(mods, "<A-S-e>", "<Cmd>Telescope file_browser<CR>")

map(mods, "<A-Right>", "<Esc><C-w>l")
map(mods, "<A-Left>", "<Esc><C-w>h")
map(mods, "<A-Up>", "<Esc><C-w>k")
map(mods, "<A-Down>", "<Esc><C-w>j")


map("t", "<A-Right>", "<C-\\><C-n><C-w>l", opts)
map("t", "<A-Left>", "<C-\\><C-n><C-w>h", opts)
map("t", "<A-Up>", "<C-\\><C-n><C-w>k", opts)
map("t", "<A-Down>", "<C-\\><C-n><C-w>j", opts)


map(mods, "<C-Down>", "<C-e>", opts )
map(mods, "<C-Up>", "<C-y>", opts )

