nmap { '<Leader><Leader>p', [[:silent! exec '!praktikum & disown'<CR>:redraw!<CR>]], {silent=true}}

vim.g.vimtex_imaps_leader=";"
nmap {'csm', 'cs$', {remap=true}}
nmap {'dsm', 'ds$', {remap=true}}
nmap {'cim', 'ci$', {remap=true}}
nmap {'dim', 'di$', {remap=true}}
nmap {'vim', 'vi$', {remap=true}}
nmap {'yim', 'ya$', {remap=true}}
nmap {'cam', 'ca$', {remap=true}}
nmap {'dam', 'da$', {remap=true}}
nmap {'vam', 'va$', {remap=true}}
nmap {'yam', 'ya$', {remap=true}}
nmap {'tsm', 'ts$', {remap=true}}

vim.g.tex_flavor='latex'
vim.g.vimtex_view_method='zathura'
vim.g.vimtex_view_automatic=1
vim.g.vimtex_quickfix_mode=0

vim.g.vimtex_fold_enabled = 1
vim.g.vimtex_fold_bib_enabled = 1
vim.g.vimtex_syntax_enabled = 1
vim.opt.conceallevel=2

