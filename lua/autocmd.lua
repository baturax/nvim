vim.cmd([[ autocmd VimLeave * set guicursor= | call chansend(v:stderr, "\x1b[ q") ]])

vim.cmd [[
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]]

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ timeout = 400 })
  end,
  group = highlight_group,
})

vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = "*.md",
  callback = function()
    vim.pack.add({
      "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    }, { load = true })
  end
})
