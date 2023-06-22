-- load settings, helpers, autocommands, and keybindings
require('jd.settings')

if vim.fn.argc(-1) == 0 then
    -- autocmds and keymaps can wait to load
    vim.api.nvim_create_autocmd('User', {
        group = vim.api.nvim_create_augroup('jd_core', { clear = true }),
        callback = function()
            require('jd.aucmds')
            require('jd.bindings')
        end,
    })
else
    -- load them now so they affect the opened buffers
    require('jd.aucmds')
    require('jd.bindings')
end

return {
    { 'folke/lazy.nvim', version = '*' },
}
