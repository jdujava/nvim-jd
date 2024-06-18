return {
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'VeryLazy',
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
        build = ':TSUpdate',
        init = function(plugin)
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treesitter** module to be loaded in time.
            -- Luckily, the only things that those plugins need are the custom queries, which we make available
            -- during startup.
            require('lazy.core.loader').add_to_rtp(plugin)
            require('nvim-treesitter.query_predicates')
        end,
        cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
        keys = {
            { '<C-Space>', desc = 'Increment Selection' },
            { '<BS>', desc = 'Decrement Selection', mode = 'x' },
        },
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
                    scope_incremental = false,
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
                -- stylua: ignore
                move = {
                    enable = true,
                    goto_next_start     = { [']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner' },
                    goto_next_end       = { [']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner' },
                    goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner' },
                    goto_previous_end   = { ['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner' },
                },
            },
        },
        ---@param opts TSConfig
        config = function(_, opts)
            if type(opts.ensure_installed) == 'table' then
                opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
            end
            require('nvim-treesitter.configs').setup(opts)
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        event = 'VeryLazy',
        enabled = true,
        config = function()
            -- If treesitter is already loaded, we need to run config again for textobjects
            if LazyVim.is_loaded('nvim-treesitter') then
                local opts = LazyVim.opts('nvim-treesitter')
                require('nvim-treesitter.configs').setup({ textobjects = opts.textobjects })
            end
        end,
    },

    -- Show context of the current function
    {
        'nvim-treesitter/nvim-treesitter-context',
        event = 'VeryLazy',
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
}
