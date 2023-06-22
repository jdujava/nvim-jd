local Util = require('lazy.core.util')

local M = {}

-- helper keymap functions (map, nmap, imap, ...)
for _, mode in ipairs({ '', 'i', 'v', 'n', 'c', 't', 'x', 'o', 'ia', 'ca' }) do
    _G[mode .. 'map'] = function(tbl)
        vim.keymap.set(mode, tbl[1], tbl[2], tbl[3])
    end
end

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, buffer)
        end,
    })
end

---@param plugin string
function M.has(plugin)
    return require('lazy.core.config').plugins[plugin] ~= nil
end

---@param name string
function M.opts(name)
    local plugin = require('lazy.core.config').plugins[name]
    if not plugin then
        return {}
    end
    local Plugin = require('lazy.core.plugin')
    return Plugin.values(plugin, 'opts', false)
end

function M.R(module)
    package.loaded[module] = nil
    return require(module)
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
    if values then
        if vim.opt_local[option]:get() == values[1] then
            vim.opt_local[option] = values[2]
        else
            vim.opt_local[option] = values[1]
        end
        return Util.info('Set ' .. option .. ' to ' .. vim.opt_local[option]:get(), { title = 'Option' })
    end
    vim.opt_local[option] = not vim.opt_local[option]:get()
    if not silent then
        if vim.opt_local[option]:get() then
            Util.info('Enabled ' .. option, { title = 'Option' })
        else
            Util.warn('Disabled ' .. option, { title = 'Option' })
        end
    end
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
