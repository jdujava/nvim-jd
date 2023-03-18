return {
    {
        'nvim-telescope/telescope.nvim',
        event = 'VeryLazy',
        priority = 100,
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                dir = '~/.config/nvim/bundle/telescope-messages.nvim',
                config = function()
                    require('telescope').load_extension('messages')
                end
            },
            {
                'nvim-telescope/telescope-frecency.nvim',
                dependencies = {'tami5/sqlite.lua'},
                config = function()
                    require('telescope').load_extension('frecency')
                end
            },
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = "make",
                config = function()
                    require('telescope').load_extension('fzf')
                end
            },
            {
                'nvim-telescope/telescope-ui-select.nvim',
                config = function()
                    require('telescope').load_extension('ui-select')
                end
            },
            {
                'fhill2/telescope-ultisnips.nvim',
                config = function()
                    require('telescope').load_extension('ultisnips')
                end
            },
        },
        opts = {
            defaults = {
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case'
                },
                prompt_prefix = "🔭 ",
                selection_caret = "> ",
                entry_prefix = "  ",
                multi_icon = ">",

                sorting_strategy = "ascending",
                layout_config = {
                    width = 0.85,
                    height = 0.85,
                    prompt_position = "top",

                    horizontal = { },
                    vertical = {
                        -- width_padding = 0.05,
                        -- height_padding = 1,
                        width = 0.9,
                        height = 0.95,
                        preview_height = 0.5,
                    },
                },
                -- set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
                mappings = {
                    i = {
                        ["<Esc>"] = function(...) return require('telescope.actions').close(...) end,
                        ["<C-j>"] = function(...) return require('telescope.actions').move_selection_next(...) end,
                        ["<C-k>"] = function(...) return require('telescope.actions').move_selection_previous(...) end,
                        ["<C-l>"] = function(...) return require('telescope.actions').select_default(...) end,
                        ["<C-y>"] = function(...) return require('telescope.actions').set_prompt_to_entry_value(...) end,
                        ["<A-/>"] = function(...) return require('telescope.actions').toggle_preview(...) end,
                    },
                }
            },
            pickers = {
                find_files = {
                    find_command = {
                        "fd", "--type", "f",
                        "--hidden",
                        "--follow",
                        "--strip-cwd-prefix",
                        "--ignore-file", "/home/jonas/.config/fd/ignore",
                        "--ignore-file", "/home/jonas/.config/fd/nvim-ignore",
                    },
                }
            },
            extensions = {
                frecency = {
                    show_scores = true,
                    ignore_patterns = {"*.git/*", "*.github/*", "*/tmp/*"},
                    workspaces = {
                        ["conf"] = "/home/jonas/.config",
                        ["data"] = "/home/jonas/.local/share",
                        ["doc"]  = "/home/jonas/Documents",
                        ["cus"]  = "/home/jonas/Documents/customfiles",
                    }
                },
            },
        },
        config = function(_, opts)
            require('telescope').setup(opts)
            require('plugins.telescope.setup')
            require('plugins.telescope.mappings')
        end,
    },
}
