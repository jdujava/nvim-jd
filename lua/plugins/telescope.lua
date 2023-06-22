return {
    {
        'nvim-telescope/telescope.nvim',
        event = 'VeryLazy',
        priority = 100,
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-frecency.nvim', dependencies = { 'tami5/sqlite.lua' } },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            { 'fhill2/telescope-ultisnips.nvim' },
            { 'nvim-telescope/telescope-ui-select.nvim' },
        },
        -- stylua: ignore
        keys = {
            { '<leader>A',         '<cmd>Telescope autocommands<cr>',                             desc = 'Auto Commands' },
            { '<leader>B',         '<cmd>Telescope builtin<cr>',                                  desc = 'Builtin' },
            { '<leader>c',         '<cmd>Telescope current_buffer_fuzzy_find<cr>',                desc = 'Buffer (Fuzzy)' },
            { '<leader>C',         '<cmd>Telescope commands<cr>',                                 desc = 'Commands' },
            { '<leader>f', function() require('telescope.builtin').find_files({ cwd = '~' }) end, desc = 'Find Files (home dir)' },
            { '<leader><leader>f', '<cmd>Telescope find_files<cr>',                               desc = 'Find Files (current dir)' },
            { '<leader>D',         '<cmd>Telescope diagnostics<cr>',                              desc = 'Diagnostics' },
            { '<leader>H',         '<cmd>Telescope help_tags<cr>',                                desc = 'Help Pages' },
            { '<leader><leader>H', '<cmd>Telescope highlights<cr>',                               desc = 'Search Highlight Groups' },
            { '<leader>K',         '<cmd>Telescope keymaps<cr>',                                  desc = 'Key Maps' },
            { '<leader><leader>M', '<cmd>Telescope man_pages<cr>',                                desc = 'Man Pages' },
            { '<leader>N',         '<cmd>Telescope notify<cr>',                                   desc = 'Notifications' },
            { '<leader>O',         '<cmd>Telescope vim_options<cr>',                              desc = 'Options' },
            { '<leader>R',         '<cmd>Telescope resume<cr>',                                   desc = 'Resume' },
            { '<leader><leader>R', '<cmd>Telescope reloader<cr>',                                 desc = 'Reload' },
            { '<leader>/',         '<cmd>Telescope live_grep<cr>',                                desc = 'Find in Files (Grep)' },
            { '<leader>:',         '<cmd>Telescope command_history<cr>',                          desc = 'Command History' },
            { '<leader>b',         '<cmd>Telescope buffers<cr>',                                  desc = 'Buffers' },
            {
                '<leader>p',
                function()
                    require('telescope.builtin').find_files({
                        shorten_path = false,
                        cwd = require('lspconfig.util').root_pattern('.git')(vim.fn.expand('%:p')),
                    })
                end,
                desc = 'Find Files (project)',
            },
            {
                '<leader>F',
                function()
                    require('telescope').extensions.frecency.frecency({
                        cwd = '~',
                        sorter = require('telescope.sorters').fuzzy_with_index_bias(),
                    })
                end,
                desc = 'Find Files (Frecency)',
            },
            {
                '<leader><leader>C',
                function()
                    require('telescope.builtin').colorscheme({ enable_preview = true })
                end,
                desc = 'Colorscheme with preview',
            },
            {
                '<A-Tab>',
                function()
                    require('telescope').extensions.ultisnips.ultisnips({
                        layout_strategy = 'vertical',
                    })
                end,
                desc = 'Ultisnips',
            },
        },
        opts = function()
            local actions = require('telescope.actions')
            return {
                defaults = {
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case',
                    },
                    prompt_prefix = '🔭 ',
                    selection_caret = '> ',
                    entry_prefix = '  ',
                    multi_icon = '>',
                    sorting_strategy = 'ascending',
                    layout_config = {
                        width = 0.85,
                        height = 0.85,
                        prompt_position = 'top',
                        horizontal = {},
                        vertical = {
                            width = 0.9,
                            height = 0.95,
                            preview_height = 0.5,
                        },
                    },
                    mappings = {
                        i = {
                            ['<Esc>'] = actions.close,
                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,
                            ['<C-f>'] = actions.to_fuzzy_refine,
                            ['<C-space>'] = actions.toggle_selection,
                            ['<C-l>'] = actions.select_default,
                            ['<C-y>'] = function() -- yank selected entry
                                local entry = require('telescope.actions.state').get_selected_entry()
                                vim.fn.setreg('+', entry.ordinal)
                            end,
                            ['<A-/>'] = require('telescope.actions.layout').toggle_preview,
                            ['<A-l>'] = actions.smart_send_to_loclist + actions.open_loclist,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        find_command = {
                            'fd',
                            '--type',
                            'f',
                            '--hidden',
                            '--follow',
                            '--strip-cwd-prefix',
                            '--ignore-file',
                            vim.env.HOME .. '/.config/fd/ignore',
                            '--ignore-file',
                            vim.env.HOME .. '/.config/fd/nvim-ignore',
                        },
                    },
                },
                extensions = {
                    frecency = {
                        show_scores = true,
                        disable_devicons = false,
                        ignore_patterns = { '*.git/*', '*.github/*', '*/tmp/*' },
                        workspaces = {
                            ['conf'] = vim.env.HOME .. '/.config',
                            ['data'] = vim.env.HOME .. '/.local/share',
                            ['doc'] = vim.env.HOME .. '/Documents',
                            ['cus'] = vim.env.HOME .. '/Documents/customfiles',
                        },
                    },
                },
            }
        end,
        config = function(_, opts)
            require('telescope').setup(opts)
            require('telescope').load_extension('frecency')
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('ultisnips')
            require('telescope').load_extension('ui-select')
            -- require('plugins.telescope.setup')
            -- require('plugins.telescope.mappings')
        end,
    },
}
