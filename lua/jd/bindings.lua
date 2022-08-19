vim.g.mapleader       = ' '
vim.g.maplocalleader  = ' '

-- Packer
nmap {
	'<Leader><Leader>P',
	function()
		R 'jd.plugins'
        require('packer').status()
	end
}
nmap {
	'<A-P>',
	function()
		R 'jd.plugins'
        require('packer').sync()
	end,
}

-- Alt maps
for _,i in ipairs{'h','j','k','l'} do
	nmap {'<A-'..i..'>',               '<C-w>'..i                         }
	nmap {'<A-'..string.upper(i)..'>', '<C-w>'..string.upper(i)           }
	tmap {'<A-'..i..'>',               '<C-\\><C-n><C-w>'..i              }
	tmap {'<A-'..string.upper(i)..'>', '<C-\\><C-n><C-w>'..string.upper(i)}
end

nmap {'<A-q>',     '<C-w>c' }
nmap {'<A-Q>',     ':wa<CR>:%bdelete<CR>' }
nmap {'<A-w>',     'mu:update<CR>`u' }
nmap {'<A-r>',     'ma:update<CR>:so $MYVIMRC<CR>`a' }
nmap {'<A-R>',     ':redraw!<CR>' }
tmap {'<A-R>',     '<C-\\><C-n>:FloatermUpdate<CR>' }
nmap {'<A-s>',     ':vsp|edit #<CR>' }
nmap {'<A-x>',     ':bd<CR>' }
tmap {'<A-x>',     '<C-\\><C-n>:bd!<CR>' }
nmap {'<A-X>',     ':edit #<CR>' }
nmap {'Z',         ':wqa<CR>' }
tmap {'<A-Esc>',   '<C-\\><C-n>' }
nmap {'<leader>t', ':split | call nvim_win_set_height(0, 12)<CR>:terminal<CR>' }

-- resizing with arrow keys
nmap {'<S-Up>',    ':resize +2<CR>' }
nmap {'<S-Down>',  ':resize -2<CR>' }
nmap {'<S-Left>',  ':vert resize +2<CR>' }
nmap {'<S-Right>', ':vert resize -2<CR>' }

imap {'<C-j>', '<C-n>', {remap=true}}
imap {'<C-k>', '<C-p>', {remap=true}}
cmap {'<C-j>', '<C-n>', {remap=true}}
cmap {'<C-k>', '<C-p>', {remap=true}}

map {'H', 'g^'}
map {'L', 'g$'}
nmap {'j', [[v:count == 0 ? "gj" : "j"]], {expr=true}}
nmap {'k', [[v:count == 0 ? "gk" : "k"]], {expr=true}}

nmap {'<C-j>',   ':move+1<cr>',         {silent=true}}
nmap {'<C-k>',   ':move-2<cr>',         {silent=true}}
nmap {'<C-h>',   '<<',                  {silent=true}}
nmap {'<C-l>',   '>>',                  {silent=true}}
xmap {'<C-k>',   [[:move-2<cr>gv=gv]],  {silent=true}}
xmap {'<C-j>',   [[:move'>+<cr>gv=gv]], {silent=true}}
xmap {'<C-h>',   '<gv',                 {silent=true}}
xmap {'<C-l>',   '>gv',                 {silent=true}}
xmap {'<',       '<gv',                 {silent=true}}
xmap {'>',       '>gv',                 {silent=true}}
xmap {'<Space>', 'I<Space><ESC>gv',     {silent=true}}

-- Swap words
nmap { "gw", [[mw"_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`w:noh<CR>]] }


-- Swap implementations of ` and ' jump to markers
nmap { "'", "`" }
nmap { "`", "'" }

-- Operator mode
omap { "'", "i'" }
omap { '"', 'i"' }
omap { "p", "i(" }
omap { "[", "i[", {nowait=true}}
omap { "b", "i{" }

nmap { 'q:', '<nop>' }
nmap { 'q/', '<nop>' }
nmap { 'q?', '<nop>' }
nmap { '<C-z>', '<nop>' }

-- -- Fixed I/A for visual
xmap {'I', [[mode() ==# 'v' ? "\<C-v>I" : mode() ==# 'V' ? "\<C-v>^o^I" : "I"]], {expr=true}}
xmap {'A', [[mode() ==# 'v' ? "\<C-v>A" : mode() ==# 'V' ? "\<C-v>Oo$A" : "A"]], {expr=true}}

-- Spell-check
map  {'<Leader><Leader>s', '<Cmd>setlocal spell!<CR>', {silent=true}}
imap {'<C-h>', '<c-g>u<Esc>[s1z=`]a<c-g>u', {silent=true}}

-- Replace all is aliased to S
nmap { 'S', ':%s/' }

-- Change perms -> Compile document -> Open document
nmap { '+x', '<CMD>!chmod +x "%:p"<CR>' }
nmap { '<A-W>', '<CMD>w! <bar> split <bar> terminal compiler "%:p"<CR>' }
nmap { '<leader>W', '<CMD>w! <bar> !compiler "%:p"<CR>' }
nmap { '<leader><leader>v', '<CMD>!opout "%:p"<CR><CR>' }

-- SudoWrite
nmap { '<leader>sw', '<CMD>SudoWrite<CR>' }

-- Executor
nmap { '<leader>x', '<CMD>call Executor()<CR>' }
vmap { '<leader>x', [[<CMD><C-w>exe join(getline("'<","'>"),'<Bar>')<CR>]] }
-- Save&Exec
nmap { '<leader><leader>x', '<CMD>call SaveandExec()<CR>' }
nmap { '<leader>X',         '<CMD>call SaveandExec()<CR>' }

-- Toggle hlsearch
nmap { '<A-CR>', '<CMD>let v:hlsearch=!v:hlsearch<CR>', {silent=true} }
tmap { '<A-CR>', '<C-\\><C-n><Cmd>let v:hlsearch=!v:hlsearch<CR>a', {silent=true} }
