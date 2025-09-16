v = vim
opt = v.opt
o = v.o
lsp = v.lsp
lspc = lsp.config
lspe = lsp.enable
cmd = v.cmd
add = v.pack.add
wo = v.wo
fn = v.fn
keyset = v.keymap.set
diag = v.diagnostic

gh = "https://github.com/"

add({
	gh .. "catgoose/nvim-colorizer.lua",
	gh .. "MeanderingProgrammer/render-markdown.nvim",
	{ src = gh .. "folke/tokyonight.nvim" },
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

--colorizer
require("colorizer").setup()

--lsp
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/completion") then
			vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
			vim.keymap.set("i", "<C-Space>", function()
				vim.lsp.completion.get()
			end)
		end
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

cmd([[ autocmd VimLeave * set guicursor= | call chansend(v:stderr, "\x1b[ q") ]])
cmd([[ colorscheme tokyonight-night ]])

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
