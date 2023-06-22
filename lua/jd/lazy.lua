local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    -- bootstrap lazy.nvim
    -- stylua: ignore
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup({
    spec = { { import = 'plugins' } },
    defaults = {
        lazy = true,
    },
    install = { colorscheme = { 'tokyonight', 'habamax' } },
    ui = {
        border = 'rounded',
    },
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                'gzip',
                'matchit',
                'matchparen',
                'netrwPlugin',
                'rplugin',
                'tarPlugin',
                'tohtml',
                'tutor',
                'zipPlugin',
            },
        },
    },
})
