return {
    {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
        keys = {{'<A-S>', '<CMD>StartupTime --tries 10<CR>', desc = 'StartupTime'}},
    },

    { 'tpope/vim-unimpaired', event = 'VeryLazy' },
    { 'tpope/vim-repeat', event = 'VeryLazy' },
}
