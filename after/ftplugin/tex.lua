local buf_opts = {silent=true, buffer=0, remap=true}
nmap {'csm', 'cs$', buf_opts}
nmap {'dsm', 'ds$', buf_opts}
nmap {'tsm', 'ts$', buf_opts}
nmap {'cim', 'ci$', buf_opts}
nmap {'dim', 'di$', buf_opts}
nmap {'vim', 'vi$', buf_opts}
nmap {'yim', 'ya$', buf_opts}
nmap {'cam', 'ca$', buf_opts}
nmap {'dam', 'da$', buf_opts}
nmap {'vam', 'va$', buf_opts}
nmap {'yam', 'ya$', buf_opts}

-- vim.cmd [[nnoremap <buffer> <silent> <Leader><Leader>i : silent! exec '!figuressetup > /dev/null 2>&1 & disown'<CR><CR>:redraw!<CR>]]
-- vim.cmd [[inoremap <buffer> <silent> <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>]]
-- vim.cmd [[nnoremap <buffer> <silent> <C-f> :silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>]]
