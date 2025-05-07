local M = {}

---@type LazyKeysLspSpec[]|nil
M._keys = nil

---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string|string[], cond?:fun():boolean}
---@alias LazyKeysLsp LazyKeys|{has?:string|string[], cond?:fun():boolean}

---@return LazyKeysLspSpec[]
function M.get()
    if M._keys then
        return M._keys
    end
    -- stylua: ignore
    M._keys = {
        { 'gL', '<cmd>LspInfo<cr>', desc = 'Lsp Info' },
        { 'gw', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',         desc = 'Workspace Symbols' },
        { 'gd', '<cmd>Telescope lsp_definitions reuse_win=true<cr>',        desc = 'Goto Definition', has = 'definition' },
        { 'gr', '<cmd>Telescope lsp_references<cr>',                        desc = 'References', nowait = true },
        { 'gI', '<cmd>Telescope lsp_implementations reuse_win=true<cr>',    desc = 'Goto Implementation' },
        { 'gT', '<cmd>Telescope lsp_type_definitions reuse_win=true<cr>',   desc = 'Goto Type Definition' },
        { 'gD', vim.lsp.buf.declaration,                                    desc = 'Goto Declaration' },
        { 'K',  function() vim.lsp.buf.hover() end,                         desc = 'Hover', has = 'hover' },
        { 'gK', function() vim.lsp.buf.hover() end,                         desc = 'Hover', has = 'hover' },
        { 'gR', vim.lsp.buf.rename,                                         desc = 'Rename', has = 'rename' },
        { 'gA', vim.lsp.buf.code_action, mode = { 'n', 'v' },               desc = 'Code Action', has = 'codeAction' },
        { 'gS', function() vim.lsp.buf.signature_help() end,                desc = 'Signature Help', has = 'signatureHelp' },
        { '<c-s>', function() vim.lsp.buf.signature_help() end, mode = 'i', desc = 'Signature Help', has = 'signatureHelp' },
    }

    return M._keys
end

---@param method string|string[]
function M.has(buffer, method)
    if type(method) == 'table' then
        for _, m in ipairs(method) do
            if M.has(buffer, m) then
                return true
            end
        end
        return false
    end
    method = method:find('/') and method or 'textDocument/' .. method
    local clients = LazyVim.lsp.get_clients({ bufnr = buffer })
    for _, client in ipairs(clients) do
        if client:supports_method(method) then
            return true
        end
    end
    return false
end

---@return LazyKeysLsp[]
function M.resolve(buffer)
    local Keys = require('lazy.core.handler.keys')
    if not Keys.resolve then
        return {}
    end
    local spec = vim.tbl_extend('force', {}, M.get())
    local opts = LazyVim.opts('nvim-lspconfig')
    local clients = LazyVim.lsp.get_clients({ bufnr = buffer })
    for _, client in ipairs(clients) do
        local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
        vim.list_extend(spec, maps)
    end
    return Keys.resolve(spec)
end

function M.on_attach(_, buffer)
    local Keys = require('lazy.core.handler.keys')
    local keymaps = M.resolve(buffer)

    for _, keys in pairs(keymaps) do
        local has = not keys.has or M.has(buffer, keys.has)
        local cond = not (keys.cond == false or ((type(keys.cond) == 'function') and not keys.cond()))

        if has and cond then
            local opts = Keys.opts(keys)
            opts.cond = nil
            opts.has = nil
            opts.silent = opts.silent ~= false
            opts.buffer = buffer
            vim.keymap.set(keys.mode or 'n', keys.lhs, keys.rhs, opts)
        end
    end
end

function M.lua_hover()
    local original_iskeyword = vim.bo.iskeyword

    vim.bo.iskeyword = vim.bo.iskeyword .. ',.'
    local word = vim.fn.expand('<cword>') --[[@as string]]

    vim.bo.iskeyword = original_iskeyword

    -- TODO: This is kind of a lame hack... since you could rename `vim.api` -> `a` or similar
    if string.find(word, 'vim.api') then
        local _, finish = string.find(word, 'vim.api.')
        local api_function = string.sub(word, finish + 1)

        vim.cmd.help(api_function)
        return
    elseif string.find(word, 'vim.fn') then
        local _, finish = string.find(word, 'vim.fn.')
        local api_function = string.sub(word, finish + 1) .. '()'

        vim.cmd.help(api_function)
        return
    else
        -- TODO: This should be exact match only. Not sure how to do that with `:help`
        -- TODO: Let users determine how magical they want the help finding to be
        local ok = pcall(vim.cmd.help, word)

        if not ok then
            local split_word = vim.split(word, '.', { plain = true })
            ok = pcall(vim.cmd.help, split_word[#split_word])
        end

        if not ok then
            vim.lsp.buf.hover()
        end
    end
end

return M
