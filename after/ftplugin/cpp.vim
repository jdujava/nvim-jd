" set foldmethod=syntax
" syntax on
setlocal foldlevel=1
setlocal foldnestmax=2
setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()

nnoremap <buffer> <A-W> :w <bar> split <bar> terminal g++ -Wall -Ofast '%' -o '%:r' && ./'%:r' \| tee '%:r'.data<CR>
nnoremap <buffer> <A-G> :w <bar> exec '!g++ -Wall -Og -g '.shellescape('%').' -o '.shellescape('%:r')<CR>

let g:termdebug_wide = 163
packadd termdebug
map <buffer> <Leader><Leader>td :Termdebug %:p:r<CR>
map <buffer> \r :Run<CR>
map <buffer> \n :Over<CR>
map <buffer> \s :Step<CR>
map <buffer> \c :Continue<CR>
map <buffer> \b :Break<CR>
map <buffer> \C :Clear<CR>
map <buffer> \f :Finish<CR>
map <buffer> \S :Stop<CR>
map <buffer> \w :call TermDebugSendCommand('where')<CR>
