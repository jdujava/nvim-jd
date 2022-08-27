-- local buf_opts = {silent=true, buffer=0}

-- nmap { 'gK', '<CMD>VimtexDocPackage<CR>', buf_opts}

-- vim.cmd [[nnoremap <buffer> <silent> <Leader><Leader>i : silent! exec '!figuressetup > /dev/null 2>&1 & disown'<CR><CR>:redraw!<CR>]]
-- vim.cmd [[inoremap <buffer> <silent> <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>]]
-- vim.cmd [[nnoremap <buffer> <silent> <C-f> :silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>]]
