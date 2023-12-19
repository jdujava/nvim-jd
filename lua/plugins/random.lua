return {
    {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
        keys = { { '<A-S>', '<CMD>StartupTime --tries 10<CR>', desc = 'StartupTime' } },
    },

    { 'tpope/vim-unimpaired', event = 'VeryLazy' },
    { 'tpope/vim-repeat', event = 'VeryLazy' },
    { 'tjdevries/sPoNGe-BoB.NvIm', event = 'VeryLazy' },
    { 'lewis6991/whatthejump.nvim', event = 'VeryLazy', pin = true },
}
