vim.o.autochdir      = true
vim.o.cmdheight      = 0
vim.o.showmode       = false
vim.o.showmatch      = true
vim.o.number         = true
vim.o.relativenumber = true
vim.o.scrolloff      = 10
vim.o.sidescrolloff  = 8

vim.o.tabstop        = 4
vim.o.shiftwidth     = 4
vim.o.softtabstop    = 4
vim.o.expandtab      = true
vim.o.cindent        = true
vim.o.breakindent    = true
vim.o.showbreak      = '> '
vim.o.linebreak      = true

vim.o.ignorecase     = true
vim.o.smartcase      = true
vim.o.smartindent    = true

vim.o.foldmethod     = 'marker'
vim.o.foldmarker     = '{{{,}}}'
-- vim.opt.foldmethod   = 'expr'
-- vim.opt.foldexpr     = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel      = 1
vim.opt.foldnestmax    = 2

vim.o.jumpoptions    = 'view'
vim.o.inccommand     = 'nosplit'
vim.o.virtualedit    = 'block'
vim.o.splitbelow     = true
vim.o.splitright     = true
vim.o.clipboard      = 'unnamedplus'
vim.o.completeopt    = 'menu,menuone,noselect'
vim.o.spelllang      = 'sk,en_us'
vim.o.signcolumn     = 'yes'
vim.o.mouse          = 'a'
vim.o.pumheight      = 15
vim.o.pumblend       = 5
vim.o.timeoutlen     = 500
vim.o.updatetime     = 200 -- Save swap file and trigger CursorHold
vim.o.backup         = true
vim.o.undofile       = true
vim.o.undolevels     = 10000
vim.o.backupdir      = vim.fn.stdpath("state") .. "/backup"
vim.o.shada          = [[!,'100,<50,s10,/100,:1000,h]]
vim.o.list           = true
vim.opt.listchars    = {
    tab = "> ",
    trail = "_",
    extends = "»",
    precedes = "«",
    nbsp = "·",
}
vim.opt.fillchars    = {
    vert = "│",
    foldopen = "",
    foldclose = "",
    fold = "·",
    foldsep = "│",
    diff = "╱",
    eob = " ",
}
vim.opt.shortmess:append { A = true, I = true, c = true, C = true }
