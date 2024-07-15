return {
    {
        'SirVer/ultisnips',
        event = 'VeryLazy',
        dependencies = { 'honza/vim-snippets' },
        keys = { { '<Leader>se', '<Cmd>UltiSnipsEdit<CR>', desc = 'Edit UltiSnipts' } },
        init = function()
            vim.g.UltiSnipsEditSplit = 'vertical'
            vim.g.UltiSnipsExpandOrJumpTrigger = '<tab>'
            vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
            vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
        end,
    },
}
