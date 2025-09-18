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

-- custom commands
vim.api.nvim_create_user_command("Q", function() cmd("qa!") end, {})
-- enable Coloring
vim.api.nvim_create_user_command("Colorize", function()
	add({
		gh .. "catgoose/nvim-colorizer.lua",
	})
	require("colorizer").setup()
	require("colorizer").attach_to_buffer(0, { mode = "background", css = true })
end, {})

-- git signs
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local uv = vim.loop
		local function is_git_repo(path)
			local git_dir = path .. '/.git'
			if uv.fs_stat(git_dir) then
				return true
			end
			local parent = uv.fs_realpath(path .. '/..')
			if parent == nil or parent == path then
				return false
			end
			return is_git_repo(parent)
		end
		local filepath = vim.fn.expand('%:p:h')
		if is_git_repo(filepath) then
			add({ gh .. "lewis6991/gitsigns.nvim" }, { load = true })
		end
	end,
})

-- markdown read
vim.api.nvim_create_autocmd("BufReadPre", {
	pattern = "*.md",
	callback = function()
		add({
			"https://github.com/MeanderingProgrammer/render-markdown.nvim",
		}, { load = true })
	end
})

-- tree-sitter
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end
})

--lsp
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local bufnr = ev.buf

		if client and client.supports_method and client:supports_method("textDocument/completion") then
			vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
			vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })

			vim.api.nvim_create_autocmd("InsertCharPre", {
				buffer = bufnr,
				callback = function(args)
					local clients = vim.lsp.get_clients({ bufnr = args.buf })
					for _, clien in ipairs(clients) do
						if type(clien) == "table"
								and type(clien.supports_method) == "function"
								and clien:supports_method("textDocument/completion") then
							vim.defer_fn(function()
								vim.lsp.completion.get()
							end, 20)
							break
						end
					end
				end,
			})
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
opt.listchars = { tab = " ", multispace = " ", trail = "", extends = "⟩", precedes = "⟨" }
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
o.showmatch = true
o.foldenable = true
o.foldlevel = 99
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.cmdheight = 0
o.laststatus = 0

wo.foldexpr = " v:lua.vim.treesitter.foldexpr()"
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
g.mapleader = " "

cmd([[ autocmd VimLeave * set guicursor= | call chansend(v:stderr, "\x1b[ q") ]])

vim.cmd [[
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]]

-- keymaps
-- -- yazi
keyset({ "n", "i" }, "<A-e>", function()
	add({
		gh .. "nvim-lua/plenary.nvim",
		gh .. "mikavilpas/yazi.nvim"
	}, { load = true })
	require("yazi").yazi()
end)

-- bracket complete
local pair_map = { ["("] = ")", ["["] = "]", ["{"] = "}", ['"'] = '"', ["'"] = "'" }

for open, close in pairs(pair_map) do
  vim.keymap.set("i", open, function()
    return open .. close .. "<Left>"
  end, { expr = true, noremap = true })
end

vim.keymap.set("i", "<BS>", function()
  local col = vim.fn.col(".")
  local line = vim.fn.getline(".")

  if col > 1 and col <= #line then
    local prev_char = line:sub(col - 1, col - 1)
    local next_char = line:sub(col, col)
    if pair_map[prev_char] == next_char then
      return "<Del><BS>"
    end
  end

  local next_char = line:sub(col, col)
  for _, close in pairs(pair_map) do
    if next_char == close then
      return "<Del>"
    end
  end

  return "<BS>"
end, { expr = true, noremap = true })

-- lualine
vim.o.winbar = "%{%v:lua.MyWinbar()%}"

function _G.MyWinbar()
	local mode = vim.fn.mode()
	local current_file = vim.fn.expand("%:t")
	if current_file == "" then current_file = "[No Name]" end

	local buffers = vim.api.nvim_list_bufs()
	local filenames = {}
	for _, buf in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
			local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
			name = string.format("%s[%d]", name, buf)

			if name == "" then name = "[No Name]" end
			table.insert(filenames, name)
		end
	end

	local separator   = " | "
	local buffer_list = table.concat(filenames, separator)

	local focused     = string.format("=== %s ===", current_file)

	local modified    = vim.bo.modified and "[+]" or ""
	local row, col    = unpack(vim.api.nvim_win_get_cursor(0))
	local filetype    = vim.bo.filetype ~= "" and vim.bo.filetype or "noft"
	local right       = string.format("%s  %d:%d  ft:%s", modified, row, col, filetype)

	local mode_hl     = "%#WinBarMode#"
	local file_hl     = "%#WinBarFile#"
	local mid_hl      = "%#WinBarFocused#"
	local right_hl    = "%#WinBarPos#"
	local none        = "%#NONE#"

	return string.format(
		"%s[%s]%s  %s%s%s %%=%s%s%s %%=%s%s%s",
		mode_hl, mode, none,
		file_hl, buffer_list, none,
		mid_hl, focused, none,
		right_hl, right, none
	)
end

-- Lsp Configs
-- go

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		local base_params = vim.lsp.util.make_range_params(nil, "utf-8")
		local params = {
			textDocument = base_params.textDocument,
			range = base_params.range,
			context = { only = { "source.organizeImports" } }
		}
		params.context = { only = { "source.organizeImports" } }
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				end
			end
		end
		vim.lsp.buf.format({ async = false })
	end
})


-- lua
lspc("lua_ls", {
	on_init = function(client)
		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
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
lspe("pyright")
