return {
    {
        "rcarriga/nvim-notify",
        event = 'VeryLazy',
        keys = {{
            '<A-Space>',
            function() require("notify").dismiss {} end,
            desc = "Dismiss notification"
        }},
        opts = {
            background_colour = "#000000",
            max_height = function() return math.floor(vim.o.lines * 0.75) end,
            max_width = function() return math.floor(vim.o.columns * 0.75) end,
            timeout = 3000,
            top_down = false,
            -- render = "minimal",
        },
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

    -- noicer ui
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = {
            lsp = {
                progress = { enabled = false },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = true,
                lsp_doc_border = true,
            },
            routes = {
                { filter = { event = "msg_show", kind = "search_count" }, opts = { skip = true } },
                { filter = { event = "msg_show", kind = "", find = "written" }, opts = { skip = true } },
                { filter = { event = "msg_show", kind = "wmsg", find = "BOTTOM" }, opts = { skip = true } },
                { filter = { event = "msg_show", kind = "emsg", find = "E353" }, opts = { skip = true } },
                { view = "notify", filter = { event = "msg_showmode" }, }, -- notify start of macro recorging
            },
        },
        -- stylua: ignore
        keys = {
            { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
            { "<leader>sl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
            { "<leader>sa", function() require("noice").cmd("all") end, desc = "Noice History" },
            { "<leader>M", function() require("noice").cmd("telescope") end, desc = "Noice Telescope" },
            { "<c-d>", function() if not require("noice.lsp").scroll(4) then return "<c-d>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
            { "<c-u>", function() if not require("noice.lsp").scroll(-4) then return "<c-u>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
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
        'norcalli/nvim-colorizer.lua',
        branch = 'color-editor',
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

    -- indent guides for Neovim
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            -- char = "▏",
            char = "│",
            filetype_exclude = { "help", "lazy" },
            show_trailing_blankline_indent = false,
            show_current_context = false,
        },
    },
}
