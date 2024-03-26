return {
    {
        'nvim-telescope/telescope.nvim',
        event = 'VeryLazy',
        cmd = 'Telescope',
        priority = 100,
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-frecency.nvim' },
            { 'fhill2/telescope-ultisnips.nvim' },
            { 'rcarriga/nvim-notify' },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                config = function()
                    LazyVim.on_load('telescope.nvim', function()
                        require('telescope').load_extension('fzf')
                    end)
                end,
            },
        },
        -- stylua: ignore
        keys = {
            -- TODO: maybe copy parts LazyVim config
            { '<leader>A',          '<cmd>Telescope autocommands<cr>',              desc = 'Auto Commands' },
            { '<leader>B',          '<cmd>Telescope builtin<cr>',                   desc = 'Builtin' },
            { '<leader>c',          '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Buffer (Fuzzy)' },
            { '<leader>C',          '<cmd>Telescope commands<cr>',                  desc = 'Commands' },
            { '<leader>f',          '<cmd>Telescope find_files cwd=~<cr>',          desc = 'Find Files (home dir)' },
            { '<leader><leader>f',  '<cmd>Telescope find_files<cr>',                desc = 'Find Files (current dir)' },
            { '<leader>D',          '<cmd>Telescope diagnostics<cr>',               desc = 'Diagnostics' },
            { '<leader>H',          '<cmd>Telescope help_tags<cr>',                 desc = 'Help Pages' },
            { '<leader><leader>H',  '<cmd>Telescope highlights<cr>',                desc = 'Search Highlight Groups' },
            { '<leader>J',          '<cmd>Telescope jumplist<cr>',                  desc = 'Jumplist' },
            -- { '<leader>K',          '<cmd>Telescope keymaps<cr>',                   desc = 'Key Maps' },
            { '<leader><leader>M',  '<cmd>Telescope man_pages<cr>',                 desc = 'Man Pages' },
            { '<leader>N',          '<cmd>Telescope notify<cr>',                    desc = 'Notifications' },
            { '<leader>O',          '<cmd>Telescope vim_options<cr>',               desc = 'Options' },
            { '<leader>R',          '<cmd>Telescope resume<cr>',                    desc = 'Resume' },
            { '<leader><leader>R',  '<cmd>Telescope reloader<cr>',                  desc = 'Reload' },
            { '<leader>?',          '<cmd>Telescope search_history<cr>',            desc = 'Search history' },
            { '<leader><leader>/',  '<cmd>Telescope live_grep<cr>',                 desc = 'Find (Grep) in Files (current dir)' },
            { '<leader>:',          '<cmd>Telescope command_history<cr>',           desc = 'Command History' },
            { '<leader>b',          '<cmd>Telescope buffers<cr>',                   desc = 'Buffers' },
            {
                '<leader>K',
                function()
                    require('telescope.builtin').keymaps({
                        lhs_filter = function(lhs)
                            return not lhs:match('Þ') -- ignore which-key prefix
                        end,
                    })
                end,
                desc = 'Keymaps',
            },
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
                        -- sorter = require('telescope.sorters').fuzzy_with_index_bias(),
                    })
                end,
                desc = 'Find Files (Frecency)',
            },
            {
                '<leader>/',
                function()
                    require('telescope.builtin').live_grep({
                        cwd = require('lspconfig.util').root_pattern('.git')(vim.fn.expand('%:p')),
                    })
                end,
                desc = 'Find (Grep) in Files (project)',
            },
            {
                '<leader><leader>C',
                function()
                    require('telescope.builtin').colorscheme({ enable_preview = true })
                end,
                desc = 'Colorscheme with preview',
            },
            {
                '<A-u>',
                function()
                    require('telescope').extensions.ultisnips.ultisnips({ layout_strategy = 'vertical' })
                end,
                mode = { 'n', 'i' },
                desc = 'Ultisnips',
            },
        },
        opts = function()
            local actions = require('telescope.actions')

            local yank_entry = function() -- yank selected entry
                local entry = require('telescope.actions.state').get_selected_entry()
                vim.fn.setreg('+', entry.ordinal)
            end
            local select_multi = function(...)
                require('telescope.actions').smart_send_to_loclist(...)
                vim.cmd.ldo('edit')
            end

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
                        '--no-require-git',
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
                            ['<C-l>'] = actions.select_default,
                            ['<A-l>'] = select_multi,
                            ['<A-L>'] = actions.smart_send_to_loclist + actions.open_loclist,
                            ['<C-space>'] = actions.toggle_selection,
                            ['<C-f>'] = actions.to_fuzzy_refine,
                            ['<C-y>'] = yank_entry,
                            ['<A-/>'] = require('telescope.actions.layout').toggle_preview,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        -- stylua: ignore
                        find_command = {
                            'fd',
                            '--type', 'file',
                            '--type', 'symlink',
                            '--follow',
                            '--hidden',
                            '--no-require-git',
                            '--strip-cwd-prefix',
                            '--ignore-file', vim.env.HOME .. '/.config/fd/ignore',
                            '--ignore-file', vim.env.HOME .. '/.config/fd/nvim-ignore',
                        },
                    },
                    live_grep = {
                        mappings = {
                            i = { ['<C-space>'] = actions.toggle_selection }, -- override the default 'to_fuzzy_refine'
                        },
                    },
                },
                extensions = {
                    frecency = {
                        db_safe_mode = false,
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
    },
}
