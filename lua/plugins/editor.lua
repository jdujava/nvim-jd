return {
    {
        'github/copilot.vim',
        event = 'CursorHold',
        keys = {
            {
                '<A-l>', 'copilot#Accept("")',
                mode = 'i',
                expr = true, replace_keycodes = false, -- important!
                silent = true, desc = 'Copilot Accept'
            },
            { '<A-p>', '<cmd>Copilot panel<CR>', mode = 'i', desc = 'Copilot Panel' },
        },
        init = function()
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_filetypes = {
                TelescopePrompt = false,
                mail = false
            }
        end
    },
    {
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        config = function()
            local ft = require('Comment.ft')
            ft.mail = '>%s'
            require('Comment').setup()
        end,
    },
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
        }
    },
    {
        'junegunn/vim-easy-align',
        keys = {
            { 'ga',      '<Plug>(EasyAlign)', mode = { 'n', 'x' }, desc = "EasyAlign"},
            { '<Enter>', '<Plug>(EasyAlign)', mode = 'v',          desc = "EasyAlign"},
        },
    },
    {
        'mbbill/undotree',
        keys = {{
            'U',
            function()
                vim.cmd [[UndotreeToggle | UndotreeFocus]]
                vim.api.nvim_win_set_width(0, 30)
                vim.o.statusline = "%!v:lua.StatusLine()"
            end,
            desc = 'Undotree'
        }},
        config = function()
            vim.g.undotree_WindowLayout = 2
        end
    },
    {
        "andymass/vim-matchup",
        event = "BufReadPost",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
        end,
    },
}
