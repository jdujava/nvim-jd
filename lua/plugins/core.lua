-- load settings, helpers, autocommands, and keybindings
require('jd.settings')
require('jd.helpers')
require('jd.aucmds')
require('jd.bindings')

-- -- can also load binding later
-- vim.api.nvim_create_autocmd('User', {
--     pattern = 'VeryLazy',
--     callback = function()
--         require('jd.bindings')
--     end,
-- })

return {
    { 'folke/lazy.nvim', version = '*' },
}
