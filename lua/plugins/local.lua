return {
    {
        dir = vim.fn.stdpath('config') .. '/lua/jd/deadkeys/',
        event = 'VeryLazy',
        keys = {
            {
                '<A-d>',
                function()
                    require('deadkeys').toggle()
                end,
                mode = { 'i', 'n' },
                desc = 'Deadkeys toggle',
            },
        },
        opts = { enabled = true },
    },

    -- statusline + bufferline
    {
        dir = vim.fn.stdpath('config') .. '/lua/jd/simple-line/',
        lazy = false,
        opts = true,
    },
}
