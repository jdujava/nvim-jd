return {
    {
        "rcarriga/nvim-notify",
        event = 'VeryLazy',
        keys = {{
            '<A-Space>',
            function() require("notify").dismiss() end,
            desc = "Dismiss notification"
        }},
        opts = {
            background_colour = "#000000",
            max_height = function() return math.floor(vim.o.lines * 0.75) end,
            max_width = function() return math.floor(vim.o.columns * 0.75) end,
            timeout = 3000,
            top_down = false,
        },
        config = function(_, opts)
            vim.notify = require("notify")
            vim.notify.setup(opts)
        end,
    },
    {
        'j-hui/fidget.nvim',
        opts = {
            text = {
                spinner = "moon",
            },
            window = {
                blend = 0,
            },
        },
    },
    {
        'kyazdani42/nvim-web-devicons',
        opts = {
            override = {
                default_icon = {
                    icon = "",
                    color = "#8b929f",
                }
            }
        }
    },
    {
        'asiryk/auto-hlsearch.nvim',
        event = 'VeryLazy',
        opts = {
            remap_keys = { "/", "?", "*", "#", "n", "N" },
        }
    },
    {
        'norcalli/nvim-colorizer.lua', branch = 'color-editor',
        keys = {
            { '<Leader><Leader>c', '<CMD>ColorizerToggle<CR>', desc = 'Toggle colorizer' },
            {
                '<Leader><Leader>C', -- TODO: conflict with telescope mapping
                function() require('colorizer').color_picker_on_cursor() end,
                desc = 'Color picker'
            },
        }
    },
    {
        "anuvyklack/windows.nvim",
        event = "WinNew",
        dependencies = {
            { "anuvyklack/middleclass" },
            { "anuvyklack/animation.nvim", enabled = false },
        },
        keys = { { "<leader>Z", "<cmd>WindowsMaximize<cr>", desc = "Maximize current window" } },
        config = function()
            vim.o.winwidth = 5
            vim.o.equalalways = false
            require("windows").setup({
                animation = { enable = false, duration = 150 },
                ignore = {
                    buftype = { "quickfix" },
                    filetype = { "undotree", "query" }
                },
            })
        end,
    },
}
