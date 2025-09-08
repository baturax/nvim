---@diagnostic disable: undefined-global
local v = vim
local o = v.opt
local g = v.g
local wo = v.wo
local api = v.api
local key = v.keymap.set
local pack = v.pack
local gh = "https://github.com/"
local lsp = v.lsp
local fn = v.fn
local diagnostic = v.diagnostic

pack.add({
	{ src = gh .. "nvim-treesitter/nvim-treesitter", branch = "main" },
	{ src = gh .. "akinsho/bufferline.nvim" },
	{ src = gh .. "altermo/ultimate-autopair.nvim", branch = "v0.6" },
  { src = gh .. "ThePrimeagen/vim-be-good" }
})


local function on_attach(client, bufnr)
	lsp.completion.enable(true, client.id, bufnr, {
		autotrigger = true,
		convert = function(item)
			return { abbr = item.label:gsub("%b()", "") }
		end,
	})

	key("i", "<C-space>", lsp.completion.get, { desc = "trigger autocompletion" })
	api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
end

local servers = { "gopls", "basedpyright", "lua_ls" }

for _, server in ipairs(servers) do
	lsp.enable(server)
	lsp.config(server, {
		on_attach = on_attach,
	})
end

-- Plugins
--
-- auto pair
require("ultimate-autopair").setup()
--
-- buffer
require("bufferline").setup({})

-- Lsp Config

-- tree-sitter
require("nvim-treesitter.configs").setup({
	ensure_installed = { "go", "gomod", "goctl", "gomod", "gosum", "lua", "markdown" },
	sync_install = true,
	auto_install = true,
	highlight = {
		enabled = true,
	},
})

require("nvim-treesitter.install").prefer_git = true

-- Settings

o.completeopt = { "menuone", "noselect", "popup" }
o.scrolloff = 10
o.termguicolors = true
o.inccommand = "split"
o.incsearch = true
o.cursorline = true
o.undofile = true
o.fillchars:append(",eob: ")
o.expandtab = true
o.softtabstop = 2
o.shiftwidth = 2
o.tabstop = 2
o.mouse = ""
o.clipboard = "unnamedplus"

v.loader.enable = true

o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
wo.relativenumber = true

g.mapleader = " "

-- Shortcuts

local i = "i"
local n = "n"
key({ i, n }, "<A-1>", "<Cmd>:b 1<Cr>")
key({ i, n }, "<A-2>", "<Cmd>:b 2<Cr>")
key({ i, n }, "<A-3>", "<Cmd>:b 3<Cr>")
key({ i, n }, "<A-4>", "<Cmd>:b 4<Cr>")
key({ i, n }, "<A-5>", "<Cmd>:b 5<Cr>")
key({ i, n }, "<A-w>", "<Cmd>:bdel<Cr>")

key("i", "<Tab>", function()
	if fn.pumvisible() == 1 then
		return fn["complete_info"]().selected ~= -1 and "<C-y>" or "<Tab>"
	else
		return "<Tab>"
	end
end, { expr = true, silent = true })

key("i", "<Down>", function()
	return fn.pumvisible() == 1 and "<C-n>" or "<Down>"
end, { expr = true, silent = true })

key("i", "<Up>", function()
	return fn.pumvisible() == 1 and "<C-p>" or "<Up>"
end, { expr = true, silent = true })

key("n", "<leader>d", function()
	diagnostic.open_float(0, { focusable = false }) -- sadece popup
end)

key("n", "<leader>ca", lsp.buf.code_action, { noremap = true, silent = true })

-- Diag

diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Functions
--
-- lsp

-- Last Place
api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		api.nvim_exec('silent! normal! g`"zv', false)
	end,
})

