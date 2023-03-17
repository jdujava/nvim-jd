require 'jd.helpers'
require 'jd.settings'
require 'jd.cmds'
require 'jd.bindings'
require 'jd.aucmds'
require 'jd.abbr'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins",
{
    defaults = {
        lazy = true,
    },
    ui = {
        border = "rounded",
    }
})

nmap {'<A-p>', function()
    require('lazy').home()
end }

-- statusline + bufferline
require 'jd.sl'

imap {'wq',   '<CMD>wq<CR>'}
imap {'qw',   '<CMD>wq<CR>'}
imap {'<CR>', '<CMD>wq<CR>'}
map  {'wq',   '<CMD>wq<CR>'}
map  {'qw',   '<CMD>wq<CR>'}
map  {'<CR>', '<CMD>wq<CR>'}

-- autostart editing as "$|$", where | is position of cursor
vim.api.nvim_buf_set_lines(0, 0, 1, 0, {"$$"})
vim.api.nvim_win_set_cursor(0, {1,1})
vim.api.nvim_create_autocmd('CursorHold', {
    once = true,
    command = 'startinsert',
    group = vim.api.nvim_create_augroup('QuickTex', {}),
})

