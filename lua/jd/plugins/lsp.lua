local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
  return
end
local map_tele = require "jd.telescope.mappings"

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local custom_attach = function()
    local buf_opts = {silent=true, buffer=0}
    nmap { '[e',         vim.diagnostic.goto_prev,                           buf_opts}
    nmap { ']e',         vim.diagnostic.goto_next,                           buf_opts}
    nmap { '<leader>vD', vim.diagnostic.setloclist,                          buf_opts}
    imap { '<c-s>',      vim.lsp.buf.signature_help,                         buf_opts}
    nmap { '<leader>vs', vim.lsp.buf.signature_help,                         buf_opts}
    nmap { '<leader>vd', vim.lsp.buf.definition,                             buf_opts}
    nmap { 'gD',         vim.lsp.buf.declaration,                            buf_opts}
    nmap { 'gT',         vim.lsp.buf.type_definition,                        buf_opts}
    nmap { 'gR',         vim.lsp.buf.rename,                                 buf_opts}
    nmap { 'gH',         vim.lsp.buf.hover,                                  buf_opts}
    nmap { 'K',          vim.lsp.buf.hover,                                  buf_opts}
    nmap { 'gF',         function() vim.lsp.buf.format { async = true } end, buf_opts}
    nmap { 'gA',         vim.lsp.buf.code_action,                            buf_opts}

    map_tele("gr",         "lsp_references",                nil,                        true)
    map_tele("gd",         "lsp_definitions",               nil,                        true)
    map_tele("gI",         "lsp_implementations",           nil,                        true)
    map_tele("<leader>wd", "lsp_document_symbols",          { ignore_filename = true }, true)
    map_tele("<leader>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)

    vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

    if vim.bo.filetype == 'lua' or vim.bo.filetype == 'vim' then
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
                    local split_word = vim.split(word, '.', {plain = true})
                    ok = pcall(vim.cmd.help, split_word[#split_word])
                end

                if not ok then
                    vim.lsp.buf.hover()
                end
            end
        end, buf_opts}
    end

    if vim.bo.filetype == 'tex' then
        nmap { 'K', '<CMD>VimtexDocPackage<CR>', buf_opts}
        nmap { 'gK', vim.lsp.buf.hover, buf_opts}

        local opts = {silent=true, buffer=0, remap=true}
        nmap {'csm', 'cs$', opts}
        nmap {'dsm', 'ds$', opts}
        nmap {'cim', 'ci$', opts}
        nmap {'dim', 'di$', opts}
        nmap {'vim', 'vi$', opts}
        nmap {'yim', 'ya$', opts}
        nmap {'cam', 'ca$', opts}
        nmap {'dam', 'da$', opts}
        nmap {'vam', 'va$', opts}
        nmap {'yam', 'ya$', opts}
        nmap {'tsm', 'ts$', opts}
    end
end

local custom_capabilities = require('cmp_nvim_lsp').default_capabilities()

local setup_server = function(server, config)
    config = vim.tbl_deep_extend("force", {
        on_init = custom_init,
        on_attach = custom_attach,
        capabilities = custom_capabilities,
        -- flags = {
        --     debounce_text_changes = 50,
        -- },
    }, config)

    lspconfig[server].setup(config)
end

local function get_lua_runtime()
    local result = {};
    for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
        local lua_path = path .. "/lua/";
        if vim.fn.isdirectory(lua_path) then
            result[lua_path] = true
        end
    end

    -- for _, path in pairs(vim.api.nvim_get_runtime_file("", true)) do
    --     -- local lua_path = path .. "/lua/";
    --     local lua_path = path;
    --     if vim.fn.isdirectory(lua_path) then
    --         result[lua_path] = true
    --     end
    -- end

    -- This loads the `lua` files from nvim into the runtime.
    result[vim.fn.expand("$VIMRUNTIME/lua")] = true

    return result;
end

require("mason-lspconfig").setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function (server_name) -- default handler (optional)
        setup_server(server_name, {})
    end,
    -- Next, you can provide targeted overrides for specific servers.
    ["ltex"] = function () end, -- disable for now
    -- ["texlab"] = function () end,
    -- ["bashls"] = function () end,
    ["clangd"] = function ()
        setup_server("clangd", {
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
            },
        })
    end,
    ["lua_ls"] = function ()
        setup_server("lua_ls", {
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        enable = true,
                        disable = { "trailing-space" },
                        -- Get the language server to recognize the `vim` global
                        globals = {
                            "vim", "c", "Group", "g", "s",
                            "map", "imap", "vmap", "nmap", "cmap", "tmap", "xmap", "omap",
                        },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        -- library = vim.api.nvim_get_runtime_file("", true),
                        library = get_lua_runtime(),
                        maxPreload = 10000,
                        preloadFileSize = 10000,
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })
    end,

})

-- Diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Enable underline, use default values
        underline = true,
        -- Enable virtual text, override spacing to 4
        virtual_text = {
            spacing = 4,
            prefix = '',
        },
        -- Enable a feature
        update_in_insert = true,
    }
)

vim.api.nvim_set_hl(0, "DiagnosticError", {fg="#f44747", bg="NONE"})
vim.api.nvim_set_hl(0, "DiagnosticWarn",  {fg="#ff8800", bg="NONE"})
vim.api.nvim_set_hl(0, "DiagnosticInfo",  {fg="#ffcc66", bg="NONE"})
vim.api.nvim_set_hl(0, "DiagnosticHint",  {fg="#9cdcfe", bg="NONE"})
vim.fn.sign_define("DiagnosticSignError", {text = "󰜺", texthl = "DiagnosticError"}) --  ERROR = "",
vim.fn.sign_define("DiagnosticSignWarn",  {text = "󱈸", texthl = "DiagnosticWarn"})  --  WARN = "",
vim.fn.sign_define("DiagnosticSignInfo",  {text = "󰋽", texthl = "DiagnosticInfo"})  --  INFO = "",
vim.fn.sign_define("DiagnosticSignHint",  {text = "󰛩", texthl = "DiagnosticHint"})  --  HINT = "",

require('lspconfig.ui.windows').default_options.border = 'rounded'
vim.api.nvim_set_hl(0, "LspInfoBorder", {link = 'FloatBorder'})

-- Jump directly to the first available definition every time.
vim.lsp.handlers["textDocument/definition"] = function(_, result)
    if not result or vim.tbl_isempty(result) then
        vim.notify("Could not find definition.", vim.log.levels.WARN, {title = "LSP"})
        return
    end

    if vim.tbl_islist(result) then
        vim.lsp.util.jump_to_location(result[1], "utf-8")
    else
        vim.lsp.util.jump_to_location(result, "utf-8")
    end
end

vim.cmd [[ LspStart ]]
