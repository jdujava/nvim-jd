-- " Similar to 'down' layout, but it uses a popup window and doesn't affect the window layout
vim.g.fzf_layout = { ['window']= { ['width']= 0.8, ['height']= 0.78, ['yoffset']= 0.50, ['border']= 'rounded' } }
-- " vim.g.fzf_layout = { ['down']= '40%' }
vim.g.fzf_colors = { ['fg']= {'fg', 'Normal'}, ['bg']= {'bg', 'Floaterm'}, ['bg+']= {'bg', 'Floaterm'}, ['border']= {'bg', 'Floaterm'}}

vim.cmd [[autocmd!_fzf_statusline]]

vim.cmd [[command! -bang -nargs=* Rg call fzf#vim#grep("rg --hidden --column --line-number --no-heading --color=always --smart-case -- ".shellescape(<q-args>), 1, <bang>0)]]
vim.cmd [[command! -bar -bang MapsI call fzf#vim#maps("i", <bang>0)]]

-- Ignore some non-text files
if vim.env.FZF_DEFAULT_COMMAND then
	vim.env.FZF_DEFAULT_COMMAND = vim.env.FZF_DEFAULT_COMMAND..' --ignore-file "$XDG_CONFIG_HOME/ripgrep/nvim-ignore"'
end

imap { '<plug>(fzf-complete-file-rg)', [[fzf#vim#complete#path('rg --files --hidden -g ""')]], {expr=true}}
imap { '<c-x><c-p>', '<plug>(fzf-complete-path)'}
imap { '<c-x><c-f>', '<plug>(fzf-complete-file-rg)'}
imap { '<c-x><c-k>', '<plug>(fzf-complete-word)'}

nmap { '<leader>a', ':Files ~<cr>' }
-- nmap { '<leader>F', ':Rg<space>' }
-- nmap { '<leader>h', ':History<cr>' }
-- nmap { '<leader>L', ':Lines<cr>' }
-- nmap { '<leader>b', ':Buffers<cr>' }
-- nmap { '<leader>c', ':Commits<cr>' }
-- nmap { '<leader>C', ':Commands<cr>' }
-- nmap { '<leader>M', ':Maps<cr>' }
-- nmap { '<leader>H', ':Helptags<cr>' }
