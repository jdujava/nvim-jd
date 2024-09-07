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
            M.copilot_on = true
            vim.cmd('Copilot enable')
            vim.cmd('Copilot status')
        else
            M.copilot_on = false
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

-- Expand `snippet`; optionally insert `feedkeys` and jump to next placeholder
function M.ultisnips_expand(snippet, feedkeys)
    -- HACK: append space in normal mode to obtain `snippet|␣` and correctly expand snippet
    --       it however works without this hack in `treesitter-ultisnips` plugin
    --          https://github.com/fhill2/telescope-ultisnips.nvim/issues/9
    local after = vim.api.nvim_get_mode().mode == 'n'
    local snip = snippet .. (after and ' ' or '')
    vim.api.nvim_put({ snip }, '', after, true)
    vim.fn['UltiSnips#ExpandSnippet']()
    -- TODO: handle table of placeholders
    if feedkeys then
        vim.api.nvim_feedkeys(feedkeys, 'n', false)
        vim.schedule(vim.fn['UltiSnips#JumpForwards'])
    end
end

return M
