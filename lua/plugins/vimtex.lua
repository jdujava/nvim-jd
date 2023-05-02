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

            --  TODO: set up a toggle for this
            vim.g.vimtex_syntax_conceal_disable = 1 -- disable conceal completely
            vim.o.conceallevel = 2

            vim.g.vimtex_matchparen_enabled = 0

            vim.g.vimtex_toc_config = {
                layer_status = { ['content'] = 1, ['label'] = 0, ['todo'] = 1, ['include'] = 0 },
                show_help = 0,
                todo_sorted = 0,
            }
        end
    }
}
