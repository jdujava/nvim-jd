local Util = require('lazy.core.util')

local M = {}

M.defaults = {
    global_enabled = true,
    filetypes = { 'mail', 'markdown' },
}

-- stylua: ignore
M.keys = {
    ["' "] = "'", ["[ "] = "[",
    ["'a"] = "á", ["'A"] = "Á",
    ["'e"] = "é", ["'E"] = "É",
    ["'i"] = "í", ["'I"] = "Í",
    ["'l"] = "ĺ", ["'L"] = "Ĺ",
    ["'o"] = "ó", ["'O"] = "Ó",
    ["'u"] = "ú", ["'U"] = "Ú",
    ["'y"] = "ý", ["'Y"] = "Ý",
    ["[a"] = "ä", ["[A"] = "Ä",
    ["[c"] = "č", ["[C"] = "Č",
    ["[d"] = "ď", ["[D"] = "Ď",
    ["[e"] = "ě", ["[E"] = "Ě",
    ["[l"] = "ľ", ["[L"] = "Ľ",
    ["[n"] = "ň", ["[N"] = "Ň",
    ["[o"] = "ô", ["[O"] = "Ô",
    ["[r"] = "ř", ["[R"] = "Ř",
    ["[s"] = "š", ["[S"] = "Š",
    ["[t"] = "ť", ["[T"] = "Ť",
    ["[u"] = "ů", ["[U"] = "Ů",
    ["[z"] = "ž", ["[Z"] = "Ž",
}

function M.map(buf)
    vim.b[buf].deadkeys_on = true
    for k, v in pairs(M.keys) do
        vim.keymap.set('i', k, v, { buffer = buf, desc = 'Deadkey' })
    end
end

function M.unmap(buf)
    vim.b[buf].deadkeys_on = false
    for k, _ in pairs(M.keys) do
        vim.keymap.del('i', k, { buffer = buf })
    end
end

function M.toggle()
    if vim.b.deadkeys_on then
        M.unmap(0)
        Util.warn('Disabled deadkey mappings', { title = 'Deadkeys' })
    else
        M.map(0)
        Util.info('Enabled deadkey mappings', { title = 'Deadkeys' })
    end
end

function M.setup(user_config)
    if user_config then
        M.defaults = vim.tbl_deep_extend('force', M.defaults, user_config)
    end

    if M.defaults.global_enabled then
        M.map()
        vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
            group = vim.api.nvim_create_augroup('DeadKeys_Global', {}),
            callback = function(event)
                M.map(event.buf)
            end,
        })
    end

    -- Enable automatically for certain filetypes
    vim.api.nvim_create_autocmd('Filetype', {
        pattern = M.defaults.filetypes,
        group = vim.api.nvim_create_augroup('DeadKeys_FileType', {}),
        callback = function(event)
            M.map(event.buf)
        end,
    })
end

return M
