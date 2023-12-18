return {
    {
        'rcarriga/nvim-notify',
        pin = true, -- pin to a specific (custom) commit
        event = 'VeryLazy',
        opts = {
            background_colour = '#000000',
            -- stylua: ignore
            max_height = function() return math.floor(vim.o.lines * 0.75) end,
            -- stylua: ignore
            max_width = function() return math.floor(vim.o.columns * 0.75) end,
            timeout = 4000,
            top_down = false,
            -- render = 'minimal',
            -- stages = 'fade_in_slide_out',
            stages = 'static', -- custom static, maybe make a PR
            -- stages = 'fade', -- also has problem with `top_down = false`
        },
    },
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
        'kyazdani42/nvim-web-devicons',
        opts = {
            override = {
                default_icon = {
                    icon = '',
                    color = '#8b929f',
                },
            },
        },
    },
    {
        'asiryk/auto-hlsearch.nvim',
        event = 'VeryLazy',
        opts = {
            remap_keys = { '/', '?', '*', '#', 'n', 'N' },
        },
    },
    {
        'anuvyklack/windows.nvim',
        event = 'WinNew',
        dependencies = {
            { 'anuvyklack/middleclass' },
            { 'anuvyklack/animation.nvim', enabled = false },
        },
        keys = { { '<leader>Z', '<cmd>WindowsMaximize<cr>', desc = 'Maximize current window' } },
        config = function()
            vim.o.winwidth = 5
            vim.o.equalalways = false
            require('windows').setup({
                animation = { enable = false, duration = 150 },
                ignore = {
                    buftype = { 'quickfix' },
                    filetype = { 'undotree', 'query' },
                },
            })
        end,
    },

    -- indent guides for Neovim
    {
        'lukas-reineke/indent-blankline.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            indent = {
                -- char = "▏",
                char = '│',
                tab_char = '│',
            },
            exclude = {
                filetypes = {
                    'help',
                    'lazy',
                    'mason',
                    'notify',
                },
            },
            scope = { enabled = false },
        },
        main = 'ibl',
    },
}
