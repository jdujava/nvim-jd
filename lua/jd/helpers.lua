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

function M.toggle_completion()
    vim.g.cmp_enabled = not vim.g.cmp_enabled
    if vim.g.cmp_enabled then
        Util.info('Enabled completion', { title = 'Completion' })
    else
        Util.warn('Disabled completion', { title = 'Completion' })
    end
end

function M.toggle_ts_highligts()
    if vim.b.ts_highlight then
        vim.treesitter.stop()
        Util.warn('Disabled TreeSitter highlights', { title = 'TreeSitter' })
    else
        vim.treesitter.start()
        Util.info('Enabled TreeSitter highlights', { title = 'TreeSitter' })
    end
end

return M
