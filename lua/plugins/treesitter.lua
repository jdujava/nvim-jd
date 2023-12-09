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
                            local Util = require('lazyvim.util')
                            local tsc = require('treesitter-context')
                            tsc.toggle()
                            if Util.inject.get_upvalue(tsc.toggle, 'enabled') then
                                Util.info('Enabled Treesitter Context', { title = 'Option' })
                            else
                                Util.warn('Disabled Treesitter Context', { title = 'Option' })
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
                'cmake',
                -- "comment", -- comments are slowing down TS bigtime, so disable for now
                'cpp',
                'css',
                'diff',
                'git_config',
                'gitignore',
                'go',
                'vimdoc',
                'html',
                'http',
                'java',
                'javascript',
                'json',
                'lua',
                'luap',
                'make',
                'markdown',
                'markdown_inline',
                'meson',
                'ninja',
                'norg',
                'org',
                'passwd',
                'php',
                'python',
                'query',
                'r',
                'regex',
                'rust',
                'scss',
                'sql',
                'sxhkdrc',
                'typescript',
                'vim',
                'yaml',
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<C-space>',
                    node_incremental = '<C-space>',
                    scope_incremental = '<nop>',
                    node_decremental = '<bs>',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        -- You can optionally set descriptions to the mappings (used in the desc parameter of
                        -- nvim_buf_set_keymap) which plugins like which-key display
                        ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
                        -- You can also use captures from other query groups like `locals.scm`
                        ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
                    },
                    -- You can choose the select mode (default is charwise 'v')
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V', -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    -- include_surrounding_whitespace = true,
                },
            },
        },
        ---@param opts TSConfig
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end,
    },
}
