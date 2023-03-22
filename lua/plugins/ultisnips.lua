return {
    {
        'SirVer/ultisnips',
        event = 'VeryLazy',
        keys = { { '<Leader>us', '<Cmd>UltiSnipsEdit<CR>', desc = "Edit UltiSnipts" } },
        init = function()
            vim.g.UltiSnipsEditSplit = "vertical"
            vim.g.UltiSnipsExpandTrigger = "<tab>"
            vim.g.UltiSnipsJumpForwardTrigger = "<tab>" -- exactly same as UltiSnipsExpandTrigger
            vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
        end,
        dependencies = {
            'honza/vim-snippets',
        }
    },
}
