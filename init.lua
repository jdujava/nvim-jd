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
