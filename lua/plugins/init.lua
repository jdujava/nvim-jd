-- load settings, helpers, autocommands, and keybindings
_G.LazyVim = require('lazyvim.util')
require('jd.settings')

-- autocmds can be loaded lazily when not opening a file
local lazy_autocmds = vim.fn.argc(-1) == 0
if not lazy_autocmds then
    require('jd.aucmds')
end

vim.api.nvim_create_autocmd('User', {
    group = vim.api.nvim_create_augroup('jd_core', { clear = true }),
    pattern = 'VeryLazy',
    callback = function()
        if lazy_autocmds then
            require('jd.aucmds')
        end
        require('jd.bindings')

        LazyVim.format.setup()
    end,
})

return {
    { 'folke/lazy.nvim', version = '*' },
    { 'LazyVim/LazyVim', version = '*' },
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            notifier = {
                -- enabled = not LazyVim.has('noice.nvim'),
                enabled = true,
                timeout = 3000,
            },
            quickfile = { enabled = true },
            statuscolumn = { enabled = false },
            words = { enabled = false },
            lazygit = { configure = false },
            styles = {
                float = {
                    border = 'rounded',
                },
                lazygit = {
                    height = 0.93,
                    width = 0.99,
                },
                notification = {
                    wo = { wrap = true }, -- Wrap notifications
                },
                -- ['notification.history'] = {
                --     width = 0.9,
                -- },
            },
        },
        -- stylua: ignore
        keys = {
            { '<leader>un', function() Snacks.notifier.hide() end,         desc = 'Dismiss All Notifications' },
            { '<leader>N',  function() Snacks.notifier.show_history() end, desc = 'Show Notification History' },
            { '<leader>bd', function() Snacks.bufdelete() end,             desc = 'Delete Buffer' },
            { '<leader>L',  function() Snacks.lazygit() end,               desc = 'Lazygit' },
            { '<leader>gb', function() Snacks.git.blame_line() end,        desc = 'Git Blame Line' },
            { '<leader>gB', function() Snacks.gitbrowse() end,             desc = 'Git Browse', mode = {'n', 'x'} },
            { '<leader>gf', function() Snacks.lazygit.log_file() end,      desc = 'Lazygit Current File History' },
            { '<leader>gl', function() Snacks.lazygit.log() end,           desc = 'Lazygit Log (cwd)' },
            { '<leader>cR', function() Snacks.rename.rename_file() end,    desc = 'Rename File' },
            { '<c-/>',      function() Snacks.terminal() end,              desc = 'Toggle Terminal' },
            { '<c-_>',      function() Snacks.terminal() end,              desc = 'which_key_ignore' },
        },
        init = function()
            vim.api.nvim_create_autocmd('User', {
                pattern = 'VeryLazy',
                callback = function()
                    -- Setup some globals for debugging (lazy-loaded)
                    _G.dd = function(...)
                        Snacks.debug.inspect(...)
                    end
                    _G.bt = function()
                        Snacks.debug.backtrace()
                    end
                    vim.print = _G.dd -- Override print to use snacks for `:=` command

                    -- Create some toggle mappings
                    Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
                    Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
                    Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
                    Snacks.toggle.diagnostics():map('<leader>ud')
                    Snacks.toggle.line_number():map('<leader>ul')
                    Snacks.toggle
                        .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                        :map('<leader>uc')
                    Snacks.toggle.treesitter():map('<leader>ut')
                    Snacks.toggle.inlay_hints():map('<leader>uh')

                    local helpers = require('jd.helpers')
                    Snacks.toggle(helpers.toggle.diagnostics):map('<leader>ud')
                    Snacks.toggle(helpers.toggle.completion):map('<leader>uC')
                end,
            })
        end,
    },
}
