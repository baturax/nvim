---@diagnostic disable-next-line: undefined-global
-- definations
local v = vim
local o = v.opt
local g = v.g
local key = v.keymap.set
local cmd = v.cmd
local lsp = v.lsp
local lspe = lsp.enable
local api = v.api
local fn = v.fn
local bo = v.bo
local treesitter = v.treesitter
local diagnostic = v.diagnostic

-- functions
-- tree sitter tree-sitter-cli must be installed
-- luarocks --lua-version=5.1 --tree=$HOME/.local/share/nvim/rocks install tree-sitter-blabla
-- ln -sf \
--  $HOME/.local/share/nvim/rocks/lib/luarocks/rocks-5.1/tree-sitter-blabla/version \
--  $HOME/.local/share/nvim/site/pack/treesitter/start/tree-sitter-blabla
api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    pcall(treesitter.start, ev.buf)
  end
})

--completion
api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    key("n", "<leader>ren", lsp.buf.rename, { buffer = ev.buf }, { desc = "Rename things" })
    key("n", "<leader>ca", lsp.buf.code_action, { buffer = ev.buf }, { desc = "Show code actions" })
    key("n", "<leader>ref", lsp.buf.references, { buffer = ev.buf }, { desc = "Show References" })
    key("n", "<leader>imp", lsp.buf.implementation, { buffer = ev.buf }, { desc = "Show Implementations" })
    key("n", "<leader>sym", lsp.buf.document_symbol, { buffer = ev.buf }, { desc = "Show Document Symbols" })
    key({ "n", "i" }, "<C-S-I>", lsp.buf.format, { buffer = ev.buf }, { desc = "Format File" })
  end,
})

-- lsp things
local function on_attach(client, bufnr)
	lsp.completion.enable(true, client.id, bufnr, {
		autotrigger = true,
		convert = function(item)
			return { abbr = item.label:gsub("%b()", "") }
		end,
	})

	key("i", "<C-space>", lsp.completion.get, { desc = "trigger autocompletion" })
  api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hovers ur ass" })

  api.nvim_create_autocmd("InsertCharPre", {
    buffer = bufnr,
    callback = function ()
      lsp.completion.get()
    end
  })
end

local servers = { "gopls", "basedpyright", "lua_ls" }

for _, server in ipairs(servers) do
	lsp.enable(server)
	lsp.config(server, {
		on_attach = on_attach,
	})
end

-- line
o.statusline = "%!v:lua.MyStatusline()"

local function ShortMode()
  local m = fn.mode()
  if m == "n" then return "N"
  elseif m == "i" then return "I"
  elseif m == "v" or m == "V" or m == "\22" then return "V"
  elseif m == "R" then return "R"
  elseif m == "c" then return ":"
  elseif m == "t" then return "T" end
  return m
end

local function Buffers()
  local current_buf = api.nvim_get_current_buf()
  local bufline = ""
  for _, bufnr in ipairs(api.nvim_list_bufs()) do
    if api.nvim_buf_is_loaded(bufnr) then
      local name = fn.fnamemodify(api.nvim_buf_get_name(bufnr), ":t")
      if name == "" then name = "[No Name]" end
      if #name > 20 then name = name:sub(1,20) .. "…" end
      local modified = bo[bufnr].modified and "+" or ""
      local readonly = bo[bufnr].readonly and "RO" or ""
      local label = bufnr .. ":" .. name .. modified .. readonly
      if bufnr == current_buf then
        bufline = bufline .. " [" .. label .. "] "
      else
        bufline = bufline .. " " .. label .. " "
      end
    end
  end
  return bufline
end

function MyStatusline()
  local bufline = Buffers()
  local mode = ShortMode()
  local filename = "%f %h%m%r"
  local pos = "%y %p%% %l:%c"
  local right
  if mode == ":" then
    right = ":" .. (g.cmdline_status or "")
  else
    right = "[" .. mode .. "] " .. pos
  end
  return bufline .. "%=" .. filename .. " " .. right
end

o.laststatus = 2
o.cmdheight = 0
g.cmdline_status = ""

api.nvim_create_autocmd({"CmdlineEnter","CmdlineLeave","CmdlineChanged"},{
  callback = function()
    g.cmdline_status = fn.getcmdline()
  end
})

-- diag
diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- settings
o.scrolloff = 10
o.inccommand = "split"
o.cursorline = true
o.cursorlineopt = "number"
o.undofile = true
o.relativenumber = true
o.clipboard = 'unnamedplus'
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.wrap = true
o.termguicolors = true
o.showmatch = true
o.completeopt = { "menuone", "noselect", "popup" }
o.foldmethod = "expr"

cmd([[autocmd BufReadPost * silent! normal! g`"]])

g.mapleader = " "

-- keymaps


