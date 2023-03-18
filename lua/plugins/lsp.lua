return {
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            'j-hui/fidget.nvim',
            'williamboman/mason.nvim',
            "williamboman/mason-lspconfig.nvim",
        },
        opts = {
            -- options for vim.diagnostic.config()
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = { spacing = 4, prefix = "●" },
                severity_sort = true,
            },
            -- LSP Server Settings
            servers = {
                ltex = {
                    enabled = false,
                },
                clangd = {
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                    },
                },
                lua_ls = {
                    -- mason = false, -- set to false if you don't want this server to be installed with mason
                    settings = {
                        Lua = {
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
                                checkThirdParty = false,
                            },
                            -- Do not send telemetry data containing a randomized but unique identifier
                            telemetry = {
                                enable = false,
                            },
                        },
                    },
                },
            },
        },
        config = function(_, opts)
            vim.diagnostic.config(opts.diagnostics)

            local on_attach = function()
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

                local map_tele = require "plugins.telescope.mappings"
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
                end
            end

            local servers = opts.servers
            local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    on_attach = on_attach,
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})
                require("lspconfig")[server].setup(server_opts)
            end

            local have_mason, mlsp = pcall(require, "mason-lspconfig")
            local available = have_mason and mlsp.get_available_servers() or {}

            local ensure_installed = {} ---@type string[]
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                    if server_opts.mason == false or not vim.tbl_contains(available, server) then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            if have_mason then
                mlsp.setup({ ensure_installed = ensure_installed })
                mlsp.setup_handlers({ setup })
            end

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
        end,
    },

    {
        'williamboman/mason.nvim',
        cmd = "Mason",
        keys = {{ '<Leader>m', '<CMD>Mason<CR>' }},
        opts = {
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                },
            },
            ensure_installed = {
                "bash-language-server",
                "clangd",
                "lua-language-server",
                "ltex-ls",
                "texlab",
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end,
    },


    {
        'j-hui/fidget.nvim',
        config = function()
            vim.api.nvim_set_hl(0, "FidgetTask", {bg = "#202020"})

            require('fidget').setup {
                window = {
                    blend = 0,              -- &winblend for the window
                },
                text = {
                    spinner = "moon",
                }
            }
        end
    },
}
