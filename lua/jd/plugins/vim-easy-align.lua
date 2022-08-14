-- Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap {'<Enter>', '<Plug>(EasyAlign)'}
nmap {'ga', '<Plug>(EasyAlign)'}
xmap {'ga', '<Plug>(EasyAlign)'}


vmap {'<leader>at', ':EasyAlign **darl<CR>'}
vmap {'<Leader><Leader>t', [[:s/\s\([.0-9a-z\\{}]\+\)/ \& \1/gi<CR>gv:s/\s*$/ \\\\/g<CR>gv:EasyAlign **darl<CR>:noh<CR>]]}
vmap {'<Leader><Leader>T', [[:s/\s\([.0-9a-z\\{}]\+\)/ \& \1/gi<CR>]]}

vim.g.easy_align_delimiters = {
	['d']= {
		['pattern']= [[\.\|\(\ \+&\ \+\)\+]],
		['left_margin']=   0,
		['right_margin']=  0,
	},
}
