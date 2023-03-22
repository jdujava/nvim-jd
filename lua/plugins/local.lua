return {
    {
        dir = vim.fn.stdpath("config") .. '/lua/jd/deadkeys.nvim/',
        event = 'VeryLazy',
        keys = { { '<A-d>', function() require('deadkeys').toggle() end, mode = { 'i', 'n' }, desc = "Deadkeys toggle" } },
        opts = { enabled = true },
    },

    -- statusline + bufferline
    {
        dir = vim.fn.stdpath("config") .. '/lua/jd/simple-line.nvim/',
        lazy = false,
        opts = true,
    },
}
