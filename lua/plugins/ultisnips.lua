return {
    {
        'SirVer/ultisnips',
        event = 'InsertEnter',
        init = function()
            vim.g.UltiSnipsEditSplit="vertical"
            vim.g.UltiSnipsExpandTrigger="<tab>"
            vim.g.UltiSnipsJumpForwardTrigger="<tab>" -- exactly same as UltiSnipsExpandTrigger
            vim.g.UltiSnipsJumpBackwardTrigger="<s-tab>"

            nmap {'<Leader>us', '<Cmd>UltiSnipsEdit<CR>' }
            -- imap {'<A-Tab>', '<Cmd>call UltiSnips#ListSnippets()<CR>', {silent=true}}
        end,
        dependencies = {
            'honza/vim-snippets',
        }
    },
}
