v = vim
opt = v.opt
o = v.o

--settings
o.relativenumber = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
opt.fillchars:append(',eob: ') 
opt.listchars = { tab = "-->", multispace = " ", trail = "", extends = "⟩", precedes = "⟨" }
o.wrap = true
o.termguicolors = true
o.scrolloff = 10
o.inccommand = "split"
o.cursorline = true
o.cursorlineopt = "number"
o.undofile = true
o.mousemodel = "extend"
o.swapfile = false

