require 'jd.helpers'
require 'jd.settings'
require 'jd.bindings'
require 'jd.aucmds'
require 'jd.abbr'

-- bootstrap lazy.nvim, LazyVim and your plugins
require 'jd.lazy'

-- set up quick keybindings
imap {'wq',   '<CMD>wq<CR>'}
imap {'qw',   '<CMD>wq<CR>'}
imap {'<CR>', '<CMD>wq<CR>'}
map  {'wq',   '<CMD>wq<CR>'}
map  {'qw',   '<CMD>wq<CR>'}
map  {'<CR>', '<CMD>wq<CR>'}

-- autostart editing as "$|$", where | is position of cursor
vim.api.nvim_buf_set_lines(0, 0, 1, 0, {"$$"})
vim.api.nvim_win_set_cursor(0, {1,1})
vim.api.nvim_create_autocmd('UIEnter', {
    command = 'startinsert',
    group = vim.api.nvim_create_augroup('QuickTex', { clear = true }),
})

