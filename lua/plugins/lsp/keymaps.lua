local M = {}

---@type PluginLspKeys
M._keys = nil

---@return (LazyKeys|{has?:string})[]
function M.get()
    local format = function()
        require("lazyvim.plugins.lsp.format").format({ force = true })
    end
    if not M._keys then
        ---@class PluginLspKeys
        -- stylua: ignore
        M._keys = {
            { '<leader>vd', vim.diagnostic.open_float, desc = 'Line Diagnostics' },
            { '<leader>vD', vim.diagnostic.setloclist, desc = 'Diagnostics to LocList' },
            { '<leader>vi', '<cmd>LspInfo<cr>',        desc = 'Lsp Info' },
            { 'gw', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', desc = 'Workspace Symbols' },
            { 'gd', function() require('telescope.builtin').lsp_definitions({ reuse_win = true }) end, desc = 'Goto Definition', has = 'definition' },
            { 'gr', '<cmd>Telescope lsp_references<cr>',        desc = 'References' },
            { 'gD', vim.lsp.buf.declaration,                    desc = 'Goto Declaration' },
            { 'gI', function() require('telescope.builtin').lsp_implementations({ reuse_win = true }) end,  desc = 'Goto Implementation' },
            { 'gT', function() require('telescope.builtin').lsp_type_definitions({ reuse_win = true }) end, desc = 'Goto Type Definition' },
            { 'K',  vim.lsp.buf.hover,                          desc = 'Hover', has = 'hover' },
            { 'gK', vim.lsp.buf.hover,                          desc = 'Hover', has = 'hover' },
            { 'gS', vim.lsp.buf.signature_help,                 desc = 'Signature Help', has = 'signatureHelp' },
            { '<c-s>', vim.lsp.buf.signature_help, mode = 'i',  desc = 'Signature Help', has = 'signatureHelp' },
            { ']d', M.diagnostic_goto(true),                    desc = 'Next Diagnostic' },
            { '[d', M.diagnostic_goto(false),                   desc = 'Prev Diagnostic' },
            { ']e', M.diagnostic_goto(true,  'ERROR'),          desc = 'Next Error' },
            { '[e', M.diagnostic_goto(false, 'ERROR'),          desc = 'Prev Error' },
            { ']w', M.diagnostic_goto(true,  'WARN'),           desc = 'Next Warning' },
            { '[w', M.diagnostic_goto(false, 'WARN'),           desc = 'Prev Warning' },
            { 'gF', format,                                     desc = 'Format Document', has = 'formatting' },
            { 'gF', format, mode = 'v',                         desc = 'Format Range', has = 'rangeFormatting' },
            { 'gR', vim.lsp.buf.rename,                         desc = 'Rename', has = 'rename' },
            { 'gA', vim.lsp.buf.code_action, mode = { 'n', 'v' },  desc = 'Code Action', has = 'codeAction' },
            {
                '<leader>vA',
                function()
                    vim.lsp.buf.code_action({
                        context = {
                            only = {
                                'source',
                            },
                            diagnostics = {},
                        },
                    })
                end,
                desc = 'Source Action',
                has = 'codeAction',
            },
        }
    end
    return M._keys
end

---@param method string
function M.has(buffer, method)
    method = method:find('/') and method or 'textDocument/' .. method
    local clients = vim.lsp.get_active_clients({ bufnr = buffer })
    for _, client in ipairs(clients) do
        if client.supports_method(method) then
            return true
        end
    end
    return false
end

function M.resolve(buffer)
    local Keys = require('lazy.core.handler.keys')
    local keymaps = {} ---@type table<string,LazyKeys|{has?:string}>

    local function add(keymap)
        local keys = Keys.parse(keymap)
        if keys[2] == false then
            keymaps[keys.id] = nil
        else
            keymaps[keys.id] = keys
        end
    end
    for _, keymap in ipairs(M.get()) do
        add(keymap)
    end

    local opts = require('lazyvim.util').opts('nvim-lspconfig')
    local clients = vim.lsp.get_active_clients({ bufnr = buffer })
    for _, client in ipairs(clients) do
        local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
        for _, keymap in ipairs(maps) do
            add(keymap)
        end
    end
    return keymaps
end

function M.on_attach(client, buffer)
    local Keys = require('lazy.core.handler.keys')
    local keymaps = M.resolve(buffer)

    for _, keys in pairs(keymaps) do
        if not keys.has or M.has(buffer, keys.has) then
            local opts = Keys.opts(keys)
            ---@diagnostic disable-next-line: no-unknown
            opts.has = nil
            opts.silent = opts.silent ~= false
            opts.buffer = buffer
            vim.keymap.set(keys.mode or 'n', keys[1], keys[2], opts)
        end
    end
end

function M.diagnostic_goto(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end

function M.lua_hover()
    local original_iskeyword = vim.bo.iskeyword

    vim.bo.iskeyword = vim.bo.iskeyword .. ',.'
    local word = vim.fn.expand('<cword>')

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
