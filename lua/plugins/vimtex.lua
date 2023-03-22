return {
    {
        'lervag/vimtex',
        lazy = false, -- otherwise reverse search does not work
        init = function()
            vim.g.vimtex_imaps_leader = ';'
            vim.g.tex_flavor = 'latex'
            vim.g.vimtex_view_method = 'zathura'
            vim.g.vimtex_quickfix_mode = 0
            vim.g.vimtex_fold_enabled = 1

            vim.g.vimtex_syntax_conceal_disable = 1 -- disable conceal completely
            vim.o.conceallevel = 2

            vim.g.vimtex_matchparen_enabled = 0
        end
    }
}
