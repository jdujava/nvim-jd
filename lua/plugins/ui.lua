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
                top_down = false,
            }

            nmap { '<A-Space>', notify.dismiss, {silent=true} }
        end,
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
            { '<Leader><Leader>c', '<CMD>ColorizerToggle<CR>' },
            { '<Leader><Leader>C', function() require('colorizer').color_picker_on_cursor() end},
        }
    },

    {
        "anuvyklack/windows.nvim",
        event = "WinNew",
        dependencies = {
            { "anuvyklack/middleclass" },
            { "anuvyklack/animation.nvim", enabled = false },
        },
        keys = { { "<leader>Z", "<cmd>WindowsMaximize<cr>", desc = "Zoom" } },
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
