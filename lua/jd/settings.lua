vim.o.autochdir      = true
-- vim.o.cmdheight      = 0       -- no cmd bar, still experimental
vim.o.showmode       = false
vim.o.showmatch      = true
vim.o.number         = true
vim.o.relativenumber = true
vim.o.scrolloff      = 10

vim.o.tabstop     = 4
vim.o.shiftwidth  = 4
vim.o.softtabstop = 4
vim.o.expandtab   = true
vim.o.cindent     = true
vim.o.breakindent = true
vim.o.showbreak   = '> '
vim.o.linebreak   = true

vim.o.ignorecase    = true
vim.o.smartcase     = true
vim.o.foldmethod    = 'marker'
-- vim.o.foldmarker    = '{{{,}}}'
-- vim.o.foldmethod = 'expr'
-- vim.o.foldexpr   = 'nvim_treesitter#foldexpr()'

vim.o.jumpoptions   = 'view'
vim.o.inccommand    = 'split'
vim.o.virtualedit   = 'block'
vim.o.splitbelow    = true
vim.o.splitright    = true
vim.o.clipboard     = 'unnamedplus'
vim.o.spelllang     = 'sk,en_us'
vim.o.signcolumn    = 'yes'
vim.o.mouse         = 'a'
vim.o.pumheight     = 25
vim.o.lazyredraw    = true
vim.o.timeoutlen    = 500
vim.o.updatetime    = 5       -- instant lazy-load of packages
vim.o.backup        = true
vim.o.undofile      = true
vim.o.undolevels    = 2000
vim.o.backupdir     = (vim.env.XDG_STATE_HOME or vim.env.HOME.."/.local/state").."/nvim/backup"
vim.o.shada         = [[!,'100,<50,s10,/100,:1000,h]]
vim.o.list          = true
-- vim.o.listchars     = [[tab:▶·,trail:_,extends:»,precedes:«,nbsp:·,eol:↲]]
vim.o.listchars     = [[tab:> ,trail:_,extends:»,precedes:«,nbsp:·]]
vim.o.fillchars     = [[vert:│,fold:·,diff:╱]]
vim.opt.shortmess:append "cI"

-- vim.o.formatoptions:remove {"c", "r", "o"}
-- vim.o.formatoptions = opt.formatoptions
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
    vim.o.termguicolors = true
    vim.o.pumblend      = 5
end

vim.cmd.colorscheme 'noice'

-- treesitter highlighting for Lua
vim.g.ts_highlight_lua = true

-- ignore some builtin plugins
vim.g.loaded_netrwPlugin    = 1
vim.g.loaded_gzip           = 1
vim.g.loaded_zipPlugin      = 1
vim.g.loaded_tarPlugin      = 1
vim.g.loaded_2html_plugin   = 1
vim.g.loaded_matchit        = 1
vim.g.loaded_matchparen     = 1
vim.g.loaded_remote_plugins = 1
