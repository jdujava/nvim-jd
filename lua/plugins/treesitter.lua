return {
    {
        'nvim-treesitter/nvim-treesitter',
        event = { 'BufReadPost', 'BufNewFile', 'VeryLazy' },
        build = ':TSUpdate',
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-context',
                event = 'BufReadPre',
                opts = { max_lines = 3 },
                keys = {
                    {
                        '<leader>uT',
                        function()
                            local tsc = require('treesitter-context')
                            tsc.toggle()
                            if LazyVim.inject.get_upvalue(tsc.toggle, 'enabled') then
                                LazyVim.info('Enabled Treesitter Context', { title = 'Option' })
                            else
                                LazyVim.warn('Disabled Treesitter Context', { title = 'Option' })
                            end
                        end,
                        desc = 'Toggle Treesitter Context',
                    },
                },
            },
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        init = function(plugin)
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treeitter** module to be loaded in time.
            -- Luckily, the only thins that those plugins need are the custom queries, which we make available
            -- during startup.
            require('lazy.core.loader').add_to_rtp(plugin)
            require('nvim-treesitter.query_predicates')
        end,
        ---@type TSConfig
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            highlight = { enable = true },
            matchup = { enable = true },
            indent = { enable = true },
            context_commentstring = { enable = true, enable_autocmd = false },
            ensure_installed = {
                'bash',
                'c',
                'printf',
                'cmake',
                -- "comment", -- comments are slowing down TS bigtime, so disable for now
                'cpp',
                'css',
                'diff',
                'git_config',
                'gitignore',
                'go',
                'gnuplot',
                'html',
                'javascript',
                'json',
                'lua',
                'make',
                'markdown',
                'markdown_inline',
                'python',
                'query',
                'scheme',
                'sxhkdrc',
                'vim',
                'vimdoc',
                'xml',
                'yaml',
                'zathurarc',
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<C-Space>',
                    node_incremental = '<C-Space>',
                    scope_incremental = '<nop>',
                    node_decremental = '<BS>',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ['af'] = { query = '@function.outer', desc = 'Select outer function' },
                        ['if'] = { query = '@function.inner', desc = 'Select inner function' },
                        ['aa'] = { query = '@call.inner', desc = 'Select inner call' }, -- TODO: also accept arguments.. learn how to do OR in treesitter queries
                        ['ia'] = { query = '@parameter.inner', desc = 'Select inner parameter' },
                    },
                },
            },
        },
        ---@param opts TSConfig
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
    },
}
