return {
    {
        'j-hui/fidget.nvim',
        opts = {
            progress = {
                display = {
                    progress_icon = { pattern = 'moon', period = 1 },
                },
            },
            notification = {
                window = { winblend = 0 },
            },
        },
    },

    -- noicer ui
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            { 'MunifTanjim/nui.nvim', lazy = true },
        },
        -- stylua: ignore
        keys = {
            { "<leader>sl", function() require("noice").cmd("last") end,      desc = "Noice Last Message" },
            { "<leader>sa", function() require("noice").cmd("all") end,       desc = "Noice History" },
            { "<A-Space>",  function() require("noice").cmd("dismiss") end,   desc = "Noice Dismiss All" },
            { "<leader>M",  function() require("noice").cmd("telescope") end, desc = "Noice Telescope" },
            { "<S-Enter>",  function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
            { "<c-d>", function() if not require("noice.lsp").scroll( 4) then return "<c-d>" end end, mode = {"i", "n", "s"}, expr = true, desc = "Scroll forward" },
            { "<c-u>", function() if not require("noice.lsp").scroll(-4) then return "<c-u>" end end, mode = {"i", "n", "s"}, expr = true, desc = "Scroll backward" },
        },
        opts = {
            lsp = {
                progress = { enabled = false },
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true,
                },
            },
            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = true,
                lsp_doc_border = true,
            },
            -- stylua: ignore
            routes = {
                { filter = { event = 'msg_show', kind = 'search_count' },        opts = { skip = true } },
                { filter = { event = 'msg_show', kind = '', find = 'written' },  opts = { skip = true } }, -- <file> written
                { filter = { event = 'msg_show', kind = 'emsg', find = 'E486' }, opts = { skip = true } }, -- search pattern not found
                -- { filter = { event = "msg_show", kind = "wmsg", find = "BOTTOM" }, opts = { skip = true } }, -- search reached BOTTOM
                -- { filter = { event = "msg_show", kind = "emsg", find = "E353" },   opts = { skip = true } },
                {
                    filter = {
                        event = "msg_show",
                        any = {
                            { find = "%d+L, %d+B" },
                            { find = "; after #%d+" },
                            { find = "; before #%d+" },
                            { find = "Already at newest change" },
                            { find = "Already at oldest change" },
                        },
                    },
                    view = "mini",
                },
            },
        },
    },

    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        keys = {
            {
                '<leader><leader>w',
                function()
                    require('which-key').show({ global = false })
                end,
                desc = 'Buffer Local Keymaps (which-key)',
            },
        },
        opts_extend = { 'spec' },
        opts = {
            plugins = { spelling = true },
            spec = {
                {
                    mode = { 'n', 'v' },
                    { '<leader>d', group = 'diagnostics/diff' },
                    { '<leader>g', group = 'diffview' },
                    { '<leader>h', group = 'hunks' },
                    { '<leader>s', group = 'noice' },
                    { '<leader>u', group = 'ui/toggle' },
                    { '<leader><space>', group = 'misc' },
                    { '[', group = 'prev' },
                    { ']', group = 'next' },
                    { 'g', group = 'goto' },
                    { 's', group = 'surround' },
                    { 'z', group = 'fold' },
                },
            },
        },
        config = function(_, opts)
            local wk = require('which-key')
            wk.setup(opts)
        end,
    },

    -- better vim.ui
    {
        'stevearc/dressing.nvim',
        lazy = true,
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require('lazy').load({ plugins = { 'dressing.nvim' } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require('lazy').load({ plugins = { 'dressing.nvim' } })
                return vim.ui.input(...)
            end
        end,
    },

    {
        'echasnovski/mini.icons',
        lazy = true,
        opts = {},
        init = function()
            package.preload['nvim-web-devicons'] = function()
                require('mini.icons').mock_nvim_web_devicons()
                return package.loaded['nvim-web-devicons']
            end
        end,
    },

    {
        'asiryk/auto-hlsearch.nvim',
        event = 'VeryLazy',
        opts = {
            remap_keys = { '/', '?', '*', '#', 'n', 'N' },
        },
    },

    -- {
    --     'anuvyklack/windows.nvim',
    --     event = 'WinNew',
    --     dependencies = {
    --         { 'anuvyklack/middleclass' },
    --         { 'anuvyklack/animation.nvim', enabled = false },
    --     },
    --     keys = { { '<leader>Z', '<cmd>WindowsMaximize<cr>', desc = 'Maximize current window' } },
    --     config = function()
    --         vim.o.winwidth = 5
    --         vim.o.equalalways = false
    --         require('windows').setup({
    --             animation = { enable = false, duration = 150 },
    --             ignore = {
    --                 buftype = { 'quickfix' },
    --                 filetype = { 'undotree', 'query' },
    --             },
    --         })
    --     end,
    -- },
    --
    -- indent guides for Neovim
    {
        'lukas-reineke/indent-blankline.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = function()
            Snacks.toggle({
                name = 'Indention Guides',
                get = function()
                    return require('ibl.config').get_config(0).enabled
                end,
                set = function(state)
                    require('ibl').setup_buffer(0, { enabled = state })
                end,
            }):map('<leader>ug')

            return {
                indent = {
                    -- char = "▏",
                    char = '│',
                    tab_char = '│',
                },
                scope = { enabled = false },
                exclude = {
                    filetypes = {
                        'help',
                        'lazy',
                        'mason',
                        'notify',
                        'snacks_notif',
                        'snacks_terminal',
                        'snacks_win',
                        'toggleterm',
                    },
                },
            }
        end,
        main = 'ibl',
    },

    { 'lewis6991/whatthejump.nvim', event = 'VeryLazy', pin = true },
}
