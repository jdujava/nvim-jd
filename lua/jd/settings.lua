local opt = vim.opt

opt.autochdir      = true
-- opt.cmdheight   = 0       -- no cmd bar, still experimental
opt.showmode       = false
opt.showmatch      = true
opt.number         = true
opt.relativenumber = true
opt.scrolloff      = 10

opt.tabstop     = 4
opt.shiftwidth  = 4
opt.softtabstop = 4
opt.expandtab   = true
opt.cindent     = true
opt.breakindent = true
opt.showbreak   = '> '
opt.linebreak   = true

opt.ignorecase    = true
opt.smartcase     = true
opt.foldmethod    = 'marker'
-- opt.foldmarker    = '{{{,}}}'
-- opt.foldmethod = 'expr'
-- opt.foldexpr   = 'nvim_treesitter#foldexpr()'

opt.jumpoptions   = 'view'
opt.inccommand    = 'split'
opt.virtualedit   = 'block'
opt.splitbelow    = true
opt.splitright    = true
opt.clipboard     = 'unnamedplus'
opt.spelllang     = 'sk,en_us'
opt.signcolumn    = 'yes'
opt.mouse         = 'a'
opt.pumheight     = 25
opt.lazyredraw    = true
opt.timeoutlen    = 500
opt.updatetime    = 5       -- instant lazy-load of packages
opt.backup        = true
opt.undofile      = true
opt.undolevels    = 2000
opt.backupdir     = (vim.env.XDG_STATE_HOME or vim.env.HOME.."/.local/state").."/nvim/backup"
opt.shada         = [[!,'100,<50,s10,/100,:100,h]]
opt.list          = true
-- opt.listchars     = [[tab:▶·,trail:_,extends:»,precedes:«,nbsp:·,eol:↲]]
opt.listchars     = [[tab:▶·,trail:_,extends:»,precedes:«,nbsp:·]]
opt.fillchars     = [[vert:│,fold:·]]
opt.shortmess:append "cI"

-- opt.formatoptions:remove {"c", "r", "o"}
-- opt.formatoptions = opt.formatoptions
--   - "a" -- Auto formatting is BAD.
--   - "t" -- Don't auto format my code. I got linters for that.
--   + "c" -- In general, I like it when comments respect textwidth
--   + "q" -- Allow formatting comments w/ gq
--   - "o" -- O and o, don't continue comments
--   + "r" -- But do continue when pressing enter.
--   + "n" -- Indent past the formatlistpat, not underneath it.
--   + "j" -- Auto-remove comments if possible.
--   - "2" -- I'm not in gradeschool anymore

if vim.env.DISPLAY then
    opt.termguicolors = true
    opt.pumblend      = 5
end

vim.cmd [[colorscheme noice]]

-- ignore some builtin plugins
vim.g.loaded_netrwPlugin    = 1
vim.g.loaded_gzip           = 1
vim.g.loaded_zipPlugin      = 1
vim.g.loaded_tarPlugin      = 1
vim.g.loaded_2html_plugin   = 1
vim.g.loaded_matchit        = 1
vim.g.loaded_matchparen     = 1
vim.g.loaded_remote_plugins = 1
