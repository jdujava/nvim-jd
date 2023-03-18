return {
    {
        'numToStr/Comment.nvim',
        event = 'CursorHold',
        config = function()
            local ft = require('Comment.ft')
            ft.mail = '>%s'

            require('Comment').setup()
        end,
    }
}
