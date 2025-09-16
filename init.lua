local v = vim
local opt = v.opt
local o = v.o
local lsp = v.lsp
local lspc = lsp.config
local lspe = lsp.enable
local cmd = v.cmd
local add = v.pack.add
local wo = v.wo
local fn = v.fn
local keyset = v.keymap.set
local diag = v.diagnostic
local g = v.g
local gh = "https://github.com/"

add({
	gh .. "catgoose/nvim-colorizer.lua",
	{ src = gh .. "nvim-treesitter/nvim-treesitter", version = "main" },
})

--tree sitter
require("nvim-treesitter").install({
	"markdown",
	"vim",
	"vimdoc",
	"lua",
	"markdown_inline",
	"go",
	"gomod",
	"gosum",
	"bash",
	"diff",
})

--status line
vim.opt.statusline = "%f %m%=%{&filetype}%=%l:%c [%p%%]"

--colorizer
require("colorizer").setup()

-- markdown read
vim.api.nvim_create_autocmd("BufReadPre", {
	pattern = "*.md",
	callback = function()
		add({
			"https://github.com/MeanderingProgrammer/render-markdown.nvim",
		}, { load = true })
	end,
})

--lsp
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client.supports_method and client:supports_method("textDocument/completion") then
			vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end

		-- keymaps
		-- -- get completions
		keyset("i", "<C-Space>", function()
			vim.lsp.completion.get()
		end)
		-- code actions
		keyset("n", "<leader>ca", function()
			lsp.buf.code_action()
		end)

		-- format code
		keyset("n", "<leader>f", function()
			lsp.buf.format()
		end)
	end,
})


--diagnostic
diag.config({
	virtual_text  = true,
	virtual_lines = true
})

--settings
v.loader.enable()
o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
opt.fillchars:append(",eob: ")
opt.listchars = { tab = " ", multispace = " ", trail = "", extends = "⟩", precedes = "⟨" }
o.wrap = true
o.breakindent = true
o.termguicolors = true
o.scrolloff = 10
o.inccommand = "split"
o.cursorline = true
o.cursorlineopt = "number"
o.undofile = true
o.mousemodel = "extend"
o.swapfile = false
o.numberwidth = 1
o.clipboard = "unnamedplus"
o.list = true
o.splitright = true
o.splitbelow = true
o.winborder = "rounded"
wo.foldexpr = " v:lua.vim.treesitter.foldexpr()"
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
g.mapleader = " "

cmd([[ autocmd VimLeave * set guicursor= | call chansend(v:stderr, "\x1b[ q") ]])
--cmd([[ colorscheme tokyonight-night ]])

vim.cmd [[
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]]


-- Lsp Configs
-- lua
lspc("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
					path ~= fn.stdpath("config")
					and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using (most
				-- likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Tell the language server how to find Lua modules same way as Neovim
				-- (see `:h lua-module-load`)
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths
					-- here.
					-- '${3rd}/luv/library'
					-- '${3rd}/busted/library'
				},
				-- Or pull in all of 'runtimepath'.
				-- NOTE: this is a lot slower and will cause issues when working on
				-- your own configuration.
				-- See https://github.com/neovim/nvim-lspconfig/issues/3189
				-- library = {
				--   vim.api.nvim_get_runtime_file('', true),
				-- }
			},
		})
	end,
	settings = {
		Lua = {},
	},
})
lspe("lua_ls")

--
--
lspe("gopls")
