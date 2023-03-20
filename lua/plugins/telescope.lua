return {
    {
        'nvim-telescope/telescope.nvim',
        event = 'VeryLazy',
        priority = 100,
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-frecency.nvim', dependencies = {'tami5/sqlite.lua'} },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = "make" },
            { 'fhill2/telescope-ultisnips.nvim' },
            { 'nvim-telescope/telescope-ui-select.nvim' },
        },
        keys = {
            { "<leader>B", "<cmd>Telescope builtin<cr>", desc = "Builtin" },
            { "<leader>/", "<cmd>Telescope live_grep<cr>" , desc = "Find in Files (Grep)" },
            { "<leader>c", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer (Fuzzy)" },
            { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
            { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            { "<leader><leader>f", "<cmd>Telescope find_files<cr>", desc = "Find Files (current dir)" },
            {
                "<leader>f",
                function() require("telescope.builtin").find_files { cwd = "~" } end,
                desc = "Find Files (home dir)"
            },
            {
                "<leader>p",
                function()
                    require("telescope.builtin").find_files {
                        shorten_path = false,
                        cwd = require("lspconfig.util").root_pattern ".git"(vim.fn.expand "%:p"),
                    }
                end,
                desc = "Find Files (project)"
            },
            {
                "<leader>F",
                function() require("telescope").extensions.frecency.frecency { cwd = "~" } end,
                desc = "Find Files (Frecency)"
            },
            {
                "<leader>N",
                function() require("telescope").extensions.notify.notify() end,
                desc = "Notifications"
            },
            { "<leader>A", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
            { "<leader>C", "<cmd>Telescope commands<cr>", desc = "Commands" },
            {
                "<leader><leader>C",
                function()
                    require("telescope.builtin").colorscheme { enable_preview = true }
                end,
                desc = "Colorscheme with preview"
            },
            { "<leader>D", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
            { "<leader>H", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
            { "<leader><leader>H", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
            { "<leader>K", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
            { "<leader><leader>M", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
            { "<leader>O", "<cmd>Telescope vim_options<cr>", desc = "Options" },
            { "<leader>R", "<cmd>Telescope resume<cr>", desc = "Resume" },
            { "<leader><leader>R", "<cmd>Telescope reloader<cr>", desc = "Reload" },
            {
                "<A-Tab>",
                function()
                    require("telescope").extensions.ultisnips.ultisnips {
                        layout_strategy = 'vertical',
                    }
                end,
                desc = "Ultisnips"
            },
            { "<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", mode = "c", nowait = true},
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
                    disable_devicons = false,
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
            require('telescope').load_extension('frecency')
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('ultisnips')
            require('telescope').load_extension('ui-select')

            vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', {fg = '#ff87d7', bg = '#262626'} )
            -- vim.api.nvim_set_hl(0, 'TelescopeMultiIcon', {fg = '#ff97e7'} )
            vim.api.nvim_set_hl(0, 'TelescopeSelection', {bg = '#262626', bold = true} )
            -- require('plugins.telescope.setup')
            -- require('plugins.telescope.mappings')
        end,
    },
}
