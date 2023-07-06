local Util = require('lazy.core.util')

local M = {}

function M.R(module)
    package.loaded[module] = nil
    return require(module)
end

function M.toggle_diagnostics()
    vim.b.diagnostics_disabled = not vim.b.diagnostics_disabled
    if vim.b.diagnostics_disabled then
        vim.diagnostic.disable(0)
        Util.warn('Disabled diagnostics', { title = 'Diagnostics' })
    else
        vim.diagnostic.enable(0)
        Util.info('Enabled diagnostics', { title = 'Diagnostics' })
    end
end

return M
