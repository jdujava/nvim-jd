-- Description: special settings for *quicktex* script
-- Run with: nvim -c "lua require('jd.quicktex')"

-- set up quick keybindings
local quit_keys = { 'wq', 'qw', '<CR>' }
for _, key in ipairs(quit_keys) do
    vim.keymap.set({ 'i', 'n' }, key, '<CMD>wq<CR>')
end

-- autostart editing as "$|$", where | is position of cursor
vim.api.nvim_buf_set_lines(0, 0, 1, false, { "$$" })
vim.api.nvim_win_set_cursor(0, { 1, 1 })
vim.cmd.startinsert()
