local opt = vim.opt

opt.autochdir     = true
opt.hidden        = true
opt.showcmd       = true
opt.showmode      = false
opt.showmatch     = true
opt.number        = true
opt.rnu           = true
opt.scrolloff     = 10


opt.autoindent = true
opt.cindent = true
opt.wrap = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.breakindent = true
opt.showbreak   = '>  '
opt.linebreak   = true

opt.ignorecase    = true
opt.smartcase     = true
opt.foldmethod    = 'marker'
opt.foldmarker    = '{{{,}}}'
-- opt.foldmethod = 'expr'
-- opt.foldexpr   = 'nvim_treesitter#foldexpr()'

-- experiment with this
-- opt.foldlevel     = 1
-- opt.foldnestmax   = 1
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
opt.pumblend      = 5
opt.lazyredraw    = true
opt.timeoutlen    = 500
opt.updatetime    = 5		-- instant lazy-load of packages
opt.backup        = true
opt.writebackup   = true
opt.undofile      = true
opt.swapfile      = true
opt.undolevels    = 2000
opt.backupdir     = (vim.env.XDG_STATE_HOME or vim.env.HOME.."/.local/state").."/nvim/backup"
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

-- -- Cursorline highlighting control
-- --  Only have it on in the active buffer
-- opt.cursorline = true -- Highlight the current line
-- local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
-- local set_cursorline = function(event, value, pattern)
--   vim.api.nvim_create_autocmd(event, {
--     group = group,
--     pattern = pattern,
--     callback = function()
--       vim.opt_local.cursorline = value
--     end,
--   })
-- end
-- set_cursorline("WinLeave", false)
-- set_cursorline("WinEnter", true)
-- set_cursorline("FileType", false, "TelescopePrompt")

if vim.env.TERM == 'st-256color' then
	vim.opt.termguicolors = true
end

vim.cmd "colorscheme noice"

-- ignore some builtin plugins
vim.g.loaded_netrwPlugin    = 1
vim.g.loaded_gzip           = 1
vim.g.loaded_zipPlugin      = 1
vim.g.loaded_tarPlugin      = 1
vim.g.loaded_2html_plugin   = 1
vim.g.loaded_matchit        = 1
vim.g.loaded_matchparen     = 1
vim.g.loaded_remote_plugins = 1

-- -- vim.g.languagetool_jar='/home/jonas/LanguageTool/languagetool.jar'
-- vim.g.languagetool_cmd='/usr/bin/languagetool'
-- vim.g.languagetool_lang="en-US"
-- -- vim.g.languagetool_server_command = '/usr/bin/languagetool --http'
-- -- vim.g.languagetool_server_command='echo "Server Started"'
-- -- vim.g.languagetool_lang="en-US"
-- -- vim.cmd[[autocmd User LanguageToolCheckDone LanguageToolSummary]]
-- -- vim.cmd[[autocmd Filetype tex LanguageToolSetUp]]
-- -- vim.g.languagetool = {
-- -- 	['.'] = {
-- -- 		['language'] = {
-- -- 			['code']= 'en-US'
-- -- 		}
-- -- 	},
-- -- }
