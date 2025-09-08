
local v = vim
local opt = v.opt
local g = v.g
local wo = vim.wo
local a = vim.api

-- Settings

opt.scrolloff = 7
opt.inccommand = "split"
opt.incsearch = true
opt.cursorline = true
opt.foldmethod = "indent"
opt.undofile = true
opt.fillchars:append(',eob: ')
opt.expandtab = true
opt.softtabstop = 2
opt.shiftwidth = 2
opt.tabstop = 2

wo.relativenumber = true
g.mapleader = " "


-- Functions
--
-- Last Place
vim.api.nvim_create_autocmd('BufRead', {
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if
          not (ft:match('commit') and ft:match('rebase'))
          and last_known_line > 1
          and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
        then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
      end,
    })
  end,
})
