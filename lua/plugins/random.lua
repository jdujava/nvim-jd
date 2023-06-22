return {
    {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
        keys = { { '<A-S>', '<CMD>StartupTime --tries 10<CR>', desc = 'StartupTime' } },
    },

    { 'tpope/vim-unimpaired', event = 'VeryLazy' },
    { 'tpope/vim-repeat', event = 'VeryLazy' },

    { 'delphinus/artify.nvim', event = 'VeryLazy' },
    -- require('artify')('foo', 'bold') --> 𝐟𝐨𝐨
    -- require('artify')('foo', 'italic') --> 𝑓𝑜𝑜
    -- require('artify')('foo', 'monospace') --> 𝚏𝚘𝚘

    { 'tjdevries/sPoNGe-BoB.NvIm', event = 'VeryLazy' },
}
