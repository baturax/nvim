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
local bo = v.bo

pack.add({
	{ src = gh .. "nvim-treesitter/nvim-treesitter", branch = "main" },
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

  api.nvim_create_autocmd("InsertCharPre", {
    buffer = buffnr,
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

-- Plugins
--
-- auto pair
--
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
o.showmatch = true
o.clipboard = "unnamedplus"
o.showmode = false

v.loader.enable = true

--o.foldmethod = "expr"
--o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
wo.relativenumber = true

g.mapleader = " "

-- Shortcuts

local i = "i"
local n = "n"
local t = "t"
key({ i, n, t }, "<A-1>", "<Cmd>:bnext<Cr>")
key({ i, n, t }, "<A-2>", "<Cmd>:bprevious<Cr>")
key({ i, n, t }, "<A-w>", "<Cmd>:bdel<Cr>")

key({i,n,t}, "<A-S-Left>", "<Cmd>:bnext<Cr>")
key({i,n,t}, "<A-S-Right>", "<Cmd>:bprevious<Cr>")

key({ "i", "n" }, "<A-Right>", "<cmd>wincmd l<cr>")
key({ "i", "n" }, "<A-Left>", "<cmd>wincmd h<cr>")
key({ "i", "n" }, "<A-Up>", "<cmd>wincmd k<cr>")
key({ "i", "n" }, "<A-Down>", "<cmd>wincmd j<cr>")

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
	diagnostic.open_float(0, { focusable = false })
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

-- buffer
--

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

-- file manager

_G.DirWin = nil
_G.DirBuf = nil

local function ListDirDepth(dir, depth)
  local files = {}
  local items = fn.readdir(dir)
  for _, f in ipairs(items) do
    if string.sub(f,1,1) ~= '.' then
      local fullpath = dir .. '/' .. f
      local icon = ''
      if fn.isdirectory(fullpath) == 1 then
        icon = '📁'
      end
      table.insert(files, icon .. ' ' .. f)
      if fn.isdirectory(fullpath) == 1 and depth > 1 then
        local subfiles = ListDirDepth(fullpath, depth - 1)
        for _, sf in ipairs(subfiles) do
          table.insert(files, '  ' .. sf)
        end
      end
    end
  end
  return files
end

function ShowDir()
  local dir = fn.expand('%:p:h')
  local files = ListDirDepth(dir, 2)

  local width = 25
  local height = math.min(#files, 15)
  local row = 1
  local col = vim.o.columns - width - 1

  local buf = _G.DirBuf
  local win = _G.DirWin

  if not win or not api.nvim_win_is_valid(win) then
    buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_lines(buf, 0, -1, false, files)
    win = api.nvim_open_win(buf, false, {
      relative = 'editor',
      row = row,
      col = col,
      width = width,
      height = height,
      style = 'minimal',
      border = 'single'
    })
    api.nvim_win_set_option(win, 'winblend', 30)
    api.nvim_win_set_option(win, 'winhl', 'Normal:Normal,FloatBorder:Normal')

    _G.DirWin = win
    _G.DirBuf = buf
  else
    buf = api.nvim_win_get_buf(win)
    api.nvim_buf_set_lines(buf, 0, -1, false, files)
    api.nvim_win_set_config(win, {
      relative = 'editor',
      row = row,
      col = col,
      width = width,
      height = height,
      style = 'minimal',
      border = 'single'
    })
  end
end

function ToggleDir()
  if _G.DirWin and api.nvim_win_is_valid(_G.DirWin) then
    api.nvim_win_close(_G.DirWin, true)
    _G.DirWin = nil
    _G.DirBuf = nil
  else
    ShowDir()
  end
end

api.nvim_create_autocmd("VimResized", {
  callback = function()
    if _G.DirWin and api.nvim_win_is_valid(_G.DirWin) then
      local width = 25
      local height = api.nvim_win_get_height(_G.DirWin)
      api.nvim_win_set_config(_G.DirWin, {
        relative = 'editor',
        row = 1,
        col = o.columns - width - 1,
        width = width,
        height = height,
        style = 'minimal',
        border = 'single'
      })
    end
  end
})

api.nvim_create_autocmd({"BufEnter", "DirChanged"}, {
  callback = function()
    if _G.DirWin and api.nvim_win_is_valid(_G.DirWin) then
      ShowDir()
    end
  end
})

api.nvim_set_keymap('n', '<A-e>', ':lua ToggleDir()<CR>', { noremap = true, silent = true })
