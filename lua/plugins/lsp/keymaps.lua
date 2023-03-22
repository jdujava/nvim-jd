local M = {}

M._keys = nil

function M.get()
    if not M._keys then
        M._keys =  {
            { "<leader>vd", vim.diagnostic.open_float,                    desc = "Line Diagnostics" },
            { "<leader>vD", vim.diagnostic.setloclist,                    desc = "Diagnostics to LocList" },
            { "<leader>vi", "<cmd>LspInfo<cr>",                           desc = "Lsp Info" },
            { "gd",         "<cmd>Telescope lsp_definitions<cr>",         desc = "Goto Definition", has = "definition" },
            { "gr",         "<cmd>Telescope lsp_references<cr>",          desc = "References" },
            { "gD",         vim.lsp.buf.declaration,                      desc = "Goto Declaration" },
            { "gI",         "<cmd>Telescope lsp_implementations<cr>",     desc = "Goto Implementation" },
            { "gT",         "<cmd>Telescope lsp_type_definitions<cr>",    desc = "Goto Type Definition" },
            { "K",          vim.lsp.buf.hover,                            desc = "Hover" },
            { "gK",         vim.lsp.buf.hover,                            desc = "Hover" },
            { "gS",         vim.lsp.buf.signature_help,                   desc = "Signature Help", has = "signatureHelp" },
            { "<c-s>",      vim.lsp.buf.signature_help, mode = "i",       desc = "Signature Help", has = "signatureHelp" },
            { "]d",         M.diagnostic_goto(true),                      desc = "Next Diagnostic" },
            { "[d",         M.diagnostic_goto(false),                     desc = "Prev Diagnostic" },
            { "]e",         M.diagnostic_goto(true,  "ERROR"),            desc = "Next Error" },
            { "[e",         M.diagnostic_goto(false, "ERROR"),            desc = "Prev Error" },
            { "]w",         M.diagnostic_goto(true,  "WARN"),             desc = "Next Warning" },
            { "[w",         M.diagnostic_goto(false, "WARN"),             desc = "Prev Warning" },
            { "gR",         vim.lsp.buf.rename,                           desc = "Rename", has = "rename" },
            { "gA",         vim.lsp.buf.code_action, mode = { "n", "v" }, desc = "Code Action", has = "codeAction" },
            { "gF",         function() vim.lsp.buf.format {async = true} end, desc = "Format"},
            {
                "<leader>vA",
                function()
                    vim.lsp.buf.code_action({
                        context = {
                            only = {
                                "source",
                            },
                            diagnostics = {},
                        },
                    })
                end,
                desc = "Source Action",
                has = "codeAction",
            }
        }
    end
    return M._keys
end

function M.on_attach(client, buffer)
    local Keys = require("lazy.core.handler.keys")
    local keymaps = {}

    for _, value in ipairs(M.get()) do
        local keys = Keys.parse(value)
        if keys[2] == vim.NIL or keys[2] == false then
            keymaps[keys.id] = nil
        else
            keymaps[keys.id] = keys
        end
    end

    for _, keys in pairs(keymaps) do
        if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
            local opts = Keys.opts(keys)
            ---@diagnostic disable-next-line: no-unknown
            opts.has = nil
            opts.silent = opts.silent ~= false
            opts.buffer = buffer
            vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
        end
    end

    -- remap hover key for lua/vim and tex files
    M.remap_hover()
end

function M.diagnostic_goto(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end

function M.remap_hover()
    local buf_opts = { silent = true, buffer = true }
    if vim.bo.filetype == 'tex' then
        nmap { 'gK', '<CMD>VimtexDocPackage<CR>', buf_opts }
    elseif vim.bo.filetype == 'lua' or vim.bo.filetype == 'vim' then
        nmap { 'K', function()
            local original_iskeyword = vim.bo.iskeyword

            vim.bo.iskeyword = vim.bo.iskeyword .. ',.'
            local word = vim.fn.expand("<cword>")

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
        end, buf_opts }
    end
end

return M
