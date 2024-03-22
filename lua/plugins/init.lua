-- load settings, helpers, autocommands, and keybindings
_G.LazyVim = require("lazyvim.util")
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
}
