return {
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
}
