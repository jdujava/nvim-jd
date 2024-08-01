-- This file is automatically loaded by plugins.core
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

vim.o.autochdir = true
vim.o.cmdheight = 0
vim.o.showmatch = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8
-- vim.o.smoothscroll = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.cindent = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.showbreak = '> ' -- don't forget to also change `st-jd/st-urlhandler`
vim.o.linebreak = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true

vim.o.commentstring = '# %s'
vim.o.foldtext = ''
vim.o.foldmethod = 'marker'
vim.o.foldmarker = '{{{,}}}'
-- vim.o.foldmethod = 'expr'
-- vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevel = 1
vim.o.foldnestmax = 2

vim.o.jumpoptions = 'view'
vim.o.inccommand = 'nosplit'
vim.o.virtualedit = 'block'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.splitkeep = 'screen'
vim.o.clipboard = 'unnamedplus'
vim.o.completeopt = 'menu,menuone,noselect'
vim.o.spelllang = 'sk,en_us'
vim.o.spellfile = vim.fn.stdpath('data') .. '/site/spell/spell.utf-8.add'
vim.o.signcolumn = 'yes'
vim.o.mouse = 'a'
vim.o.pumheight = 15
vim.o.pumblend = 5
vim.o.timeoutlen = 500
vim.o.updatetime = 200 -- Save swap file and trigger CursorHold
vim.o.backup = true
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.backupdir = vim.fn.stdpath('state') .. '/backup'
vim.o.shada = [[!,'100,<50,s10,/100,:1000,h]]
vim.o.list = true
vim.opt.listchars = {
    tab = '> ',
    trail = '_',
    extends = '»',
    precedes = '«',
    nbsp = '·',
}
vim.opt.fillchars = {
    vert = '│',
    foldopen = '',
    foldclose = '',
    fold = ' ',
    foldsep = '│',
    diff = '╱',
    eob = ' ',
}
vim.opt.shortmess:append({ A = true, I = true, c = true, C = true })
vim.opt.diffopt:append({ 'linematch:60' })

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

vim.g.markdown_folding = true

vim.g.autoformat = false
vim.o.formatexpr = 'v:lua.LazyVim.format.formatexpr()'
