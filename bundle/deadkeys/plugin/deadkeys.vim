
if exists('g:loaded_deadkeys') | finish | endif
let g:loaded_deadkeys = 1

autocmd BufEnter * silent call deadkeys#init()
silent call deadkeys#init()

nnoremap <Plug>DeadKeysToggle <Cmd>call deadkeys#toggle()<CR>
inoremap <Plug>DeadKeysToggle <Cmd>call deadkeys#toggle()<CR>
