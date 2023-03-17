return {
    {
        'nvim-telescope/telescope.nvim',
        event = 'VeryLazy',
        priority = 100,
        config = function()
            require 'plugins.telescope.setup'
            require 'plugins.telescope.mappings'
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            { dir = '~/.config/nvim/bundle/telescope-messages.nvim'},
            { 'nvim-telescope/telescope-frecency.nvim', dependencies = {'tami5/sqlite.lua'}},
            { 'nvim-telescope/telescope-fzf-native.nvim', build = "make" },
            'nvim-telescope/telescope-ui-select.nvim',
            'fhill2/telescope-ultisnips.nvim',
        }
    },
}
