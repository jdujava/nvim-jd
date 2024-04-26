return {
    {
        dir = vim.fn.stdpath('config') .. '/lua/jd/deadkeys/',
        event = { 'BufReadPost', 'BufNewFile' },
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
        opts = {
            global_enabled = false,
        },
    },

    -- statusline + bufferline
    {
        dir = vim.fn.stdpath('config') .. '/lua/jd/simple-line/',
        lazy = false,
        opts = {},
    },
}
