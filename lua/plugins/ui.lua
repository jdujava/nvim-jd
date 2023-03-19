return {
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            local log = require("plenary.log").new {
                plugin = "notify",
                level = "debug",
                use_console = false,
            }

            ---@diagnostic disable-next-line: duplicate-set-field
            vim.notify = function(msg, level, opts)
                log.info(msg, level, opts)
                if string.find(msg, "method .* is not supported") then
                    return
                end

                require "notify"(msg, level, opts)
            end

            local notify = require "notify"
            notify.setup {
                background_colour = "#000000",
                max_height = function() return math.floor(vim.o.lines * 0.75) end,
                max_width = function() return math.floor(vim.o.columns * 0.75) end,
                timeout = 3000,
                top_down = false,
            }

            nmap { '<A-Space>', notify.dismiss, {silent=true} }
        end,
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
                '<Leader><Leader>C',
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
