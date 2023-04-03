vim.opt_local.foldmethod = 'expr'
vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

local buf_opts = { silent = true, buffer = 0 }
nmap { '<A-W>', ':w <bar> split <bar> terminal g++ -Wall -Ofast % -o %:r && ./%:r | tee %:r.data<CR>', buf_opts }
nmap { '<A-G>', ':w <bar> exec "!g++ -Wall -Og -g ".shellescape("%")." -o ".shellescape("%:r")<CR>', buf_opts }

vim.g.termdebug_wide = 163
vim.cmd [[packadd termdebug]]

map { '<Leader><Leader>td', '<CMD>Termdebug %:p:r<CR>', buf_opts }
map { [[\r]], '<CMD>Run<CR>', buf_opts }
map { [[\n]], '<CMD>Over<CR>', buf_opts }
map { [[\s]], '<CMD>Step<CR>', buf_opts }
map { [[\c]], '<CMD>Continue<CR>', buf_opts }
map { [[\b]], '<CMD>Break<CR>', buf_opts }
map { [[\C]], '<CMD>Clear<CR>', buf_opts }
map { [[\f]], '<CMD>Finish<CR>', buf_opts }
map { [[\S]], '<CMD>Stop<CR>', buf_opts }
map { [[\w]], '<CMD>call TermDebugSendCommand("where")<CR>', buf_opts }
