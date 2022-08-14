nnoremap <buffer> <silent> <Leader><Leader>i : silent! exec '!figuressetup > /dev/null 2>&1 & disown'<CR><CR>:redraw!<CR>
inoremap <buffer> <silent> <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <buffer> <silent> <C-f> :silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

