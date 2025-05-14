return {
    {
        'SirVer/ultisnips',
        event = 'VeryLazy',
        dependencies = { 'honza/vim-snippets' },
        keys = {
            { '<Leader>se', '<Cmd>UltiSnipsEdit<CR>', desc = 'Edit UltiSnipts' },
            {
                '<A-a>',
                require('jd.helpers').toggle_ultisnips_autotrigger,
                desc = 'Toggle UltiSnips Autotrigger',
                mode = { 'i', 'n' },
            },
            -- {
            --     '<A-f>',
            --     function() -- https://github.com/fhill2/telescope-ultisnips.nvim/issues/9
            --         local snippet = 'foo' -- should expand to 'foo bar'
            --         local after = vim.api.nvim_get_mode().mode == 'n'
            --         vim.api.nvim_put({ snippet }, '', after, true)
            --         vim.fn['UltiSnips#ExpandSnippet']()
            --         vim.cmd([[call UltiSnips#ExpandSnippet()]])
            --     end,
            --     mode = { 'i', 'n' },
            --     desc = 'Expand foo snippet',
            -- },
        },

        init = function()
            vim.g.UltiSnipsEditSplit = 'vertical'
            vim.g.UltiSnipsExpandOrJumpTrigger = '<tab>'
            vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
            vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
        end,
    },
}
