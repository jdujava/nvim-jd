return {
    {
        'github/copilot.vim',
        event = 'CursorHold',
        init = function()
            imap { '<A-l>', 'copilot#Accept("<CR>")', {expr=true, silent=true}}
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_filetypes = { TelescopePrompt = false, mail = false }
        end
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
        dir = '~/.config/nvim/bundle/deadkeys',
        event = 'VeryLazy',
        keys = {{'<A-d>', '<Plug>DeadKeysToggle', mode = {'i', 'n'}}}
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

    { 'tpope/vim-unimpaired', event = 'VeryLazy' },
    { 'tpope/vim-repeat', event = 'VeryLazy' },

    {
        'kylechui/nvim-surround',
        event = 'VeryLazy',
        opts = {
            keymaps = {
                insert = "<C-g>s",
                insert_line = "<C-g>S",
                normal = "s",
                normal_cur = "ss",
                normal_line = "S",
                normal_cur_line = "SS",
                visual = "s",
                visual_line = "S",
                delete = "ds",
                change = "cs",
            }
            -- surrounds =      -- Defines surround keys and behavior,
            -- aliases =        -- Defines aliases,
            -- highlight =      -- Defines highlight behavior,
            -- move_cursor =    -- Defines cursor behavior,
        }
    },

    {
        'junegunn/vim-easy-align',
        keys = {
            {'ga', '<Plug>(EasyAlign)', mode = {'n','x'}},
            {'<Enter>', '<Plug>(EasyAlign)', mode = 'v'},
        },
    },

    {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
        keys = {{'<A-S>', '<CMD>StartupTime --tries 10<CR>'}},
    },

    -- auto-resize windows
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
            })
        end,
    },
}
