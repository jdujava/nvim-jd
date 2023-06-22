vim.opt_local.foldmethod = 'expr'
vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

local buf_opts = { silent = true, buffer = true }
-- vim.keymap.set('n', '<A-W>', ':w <bar> split <bar> terminal g++ -Wall -Ofast % -o %:r && ./%:r | tee %:r.data<CR>', buf_opts)
-- vim.keymap.set('n', '<A-G>', ':w <bar> exec "!g++ -Wall -Og -g ".shellescape("%")." -o ".shellescape("%:r")<CR>', buf_opts)

vim.g.termdebug_wide = 163
vim.cmd([[packadd termdebug]])

vim.keymap.set('n', '<Leader><Leader>td', '<CMD>Termdebug %:p:r<CR>', buf_opts)
vim.keymap.set('n', [[\r]], '<CMD>Run<CR>', buf_opts)
vim.keymap.set('n', [[\n]], '<CMD>Over<CR>', buf_opts)
vim.keymap.set('n', [[\s]], '<CMD>Step<CR>', buf_opts)
vim.keymap.set('n', [[\c]], '<CMD>Continue<CR>', buf_opts)
vim.keymap.set('n', [[\b]], '<CMD>Break<CR>', buf_opts)
vim.keymap.set('n', [[\C]], '<CMD>Clear<CR>', buf_opts)
vim.keymap.set('n', [[\f]], '<CMD>Finish<CR>', buf_opts)
vim.keymap.set('n', [[\S]], '<CMD>Stop<CR>', buf_opts)
vim.keymap.set('n', [[\w]], '<CMD>call TermDebugSendCommand("where")<CR>', buf_opts)
