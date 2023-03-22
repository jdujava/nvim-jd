require 'jd.helpers'
require 'jd.settings'
require 'jd.bindings'
require 'jd.aucmds'
require 'jd.abbr'

-- bootstrap lazy.nvim, LazyVim and plugins
require 'jd.lazy'

-- set up quick keybindings
local quit_keys = { 'wq', 'qw', '<CR>' }
for _, key in ipairs(quit_keys) do
    vim.keymap.set({'i','n'}, key, '<CMD>wq<CR>')
end

-- autostart editing as "$|$", where | is position of cursor
vim.api.nvim_buf_set_lines(0, 0, 1, false, { "$$" })
vim.api.nvim_win_set_cursor(0, { 1, 1 })
vim.api.nvim_create_autocmd('UIEnter', {
    command = 'startinsert',
    group = vim.api.nvim_create_augroup('QuickTex', { clear = true }),
})
