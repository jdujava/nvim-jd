return {
    {
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        config = function()
            local ft = require('Comment.ft')
            ft.mail = '>%s'

            require('Comment').setup()
        end,
    }
}
