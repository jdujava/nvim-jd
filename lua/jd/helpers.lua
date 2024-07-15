local Util = require('lazy.core.util')

local M = {}

function M.R(module)
    package.loaded[module] = nil
    return require(module)
end

---@type table<string, lazyvim.Toggle>
M.toggle = {}

---@type lazyvim.Toggle
M.toggle.diagnostics = {
    name = 'Diagnostics',
    get = function()
        return vim.diagnostic.is_enabled and vim.diagnostic.is_enabled({ bufnr = 0 })
    end,
    set = function(state)
        vim.diagnostic.enable(state, { bufnr = 0 })
    end,
}

---@type lazyvim.Toggle
M.toggle.completion = {
    name = 'Completion',
    get = function()
        return vim.g.cmp_enabled
    end,
    set = function(state)
        vim.g.cmp_enabled = state
    end,
}

M.copilot_on = false
---@type lazyvim.Toggle
M.toggle.copilot = {
    name = 'Copilot',
    get = function()
        return M.copilot_on
    end,
    set = function(state)
        if state then
            vim.cmd('Copilot enable')
            vim.cmd('Copilot status')
        else
            vim.cmd('Copilot disable')
        end
    end,
}

function M.toggle_ultisnips_autotrigger()
    if vim.fn['UltiSnips#ToggleAutoTrigger']() == 1 then
        Util.info('Enabled UltiSnips autotrigger', { title = 'UltiSnips' })
    else
        Util.warn('Disabled UltiSnips autotrigger', { title = 'UltiSnips' })
    end
end

return M
