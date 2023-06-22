return {
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            'j-hui/fidget.nvim',
            { 'folke/neodev.nvim', opts = true },
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'lvimuser/lsp-inlayhints.nvim',
        },
        ---@class PluginLspOpts
        opts = {
            -- options for vim.diagnostic.config()
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    -- prefix = "●",
                    prefix = "icons",
                },
                severity_sort = true,
                float = { border = "rounded" },
            },
            -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
            -- Be aware that you also will need to properly configure your LSP server to
            -- provide the inlay hints.
            inlay_hints = {
                enabled = true,
            },
            -- add any global capabilities here
            capabilities = {},
            -- Automatically format on save
            autoformat = false,
            -- Enable this to show formatters used in a notification
            -- Useful for debugging formatter issues
            format_notify = true,
            -- options for vim.lsp.buf.format
            -- `bufnr` and `filter` is handled by the LazyVim formatter,
            -- but can be also overridden when specified
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
            -- LSP Server Settings
            ---@type lspconfig.options
            servers = {
                ltex = {
                    enabled = true,
                    autostart = false, -- manually by ltex_extra keybinding
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
                                -- Get the language server to recognize the `*map` globals
                                globals = { "map", "imap", "vmap", "nmap", "cmap", "tmap", "xmap", "omap", "iamap", "camap" },
                            },
                            workspace = {
                                checkThirdParty = false,
                            },
                            -- Do not send telemetry data containing a randomized but unique identifier
                            telemetry = {
                                enable = false,
                            },
                            hint = {
                                enable = true,
                                setType = false,
                                paramType = true,
                                paramName = "Disable",
                                semicolon = "Disable",
                                arrayIndex = "Disable",
                            },
                        },
                    },
                },
            },
            -- you can do any additional lsp server setup here
            -- return true if you don't want this server to be setup with lspconfig
            ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
            setup = {
                -- clangd = function(_, opts)
                --     opts.capabilities.offsetEncoding = { "utf-16" }
                -- end,
                -- Specify * to use this function as a fallback for any server
                -- ["*"] = function(server, opts) end,
            },
        },
        ---@param opts PluginLspOpts
        config = function(_, opts)
            local helpers = require("jd.helpers")
            -- setup autoformat
            require("plugins.lsp.format").setup(opts)
            -- setup formatting and keymaps
            helpers.on_attach(function(client, buffer)
                require("plugins.lsp.keymaps").on_attach(client, buffer)
            end)

            -- diagnostics
            local icons = { Error = "", Warn = "", Hint = "", Info = "" }
            for name, icon in pairs(icons) do
                name = "DiagnosticSign" .. name
                vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
            end

            if opts.inlay_hints.enabled and vim.lsp.buf.inlay_hint then
                helpers.on_attach(function(client, buffer)
                    if client.server_capabilities.inlayHintProvider then
                        vim.lsp.buf.inlay_hint(buffer, true)
                    end
                end)
            end

            if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
                opts.diagnostics.virtual_text.prefix = function(diagnostic)
                    for d, icon in pairs(icons) do
                        if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                            return icon
                        end
                    end
                end
            end
            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
            require('lspconfig.ui.windows').default_options.border = 'rounded'

            -- setup servers
            local servers = opts.servers
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities(),
                opts.capabilities or {}
            )

            local function setup(server)
                local server_opts = vim.tbl_deep_extend("force", {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup["*"] then
                    if opts.setup["*"](server, server_opts) then
                        return
                    end
                end
                require("lspconfig")[server].setup(server_opts)
            end

            -- get all the servers that are available thourgh mason-lspconfig
            local have_mason, mlsp = pcall(require, "mason-lspconfig")
            local all_mslp_servers = {}
            if have_mason then
                all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
            end

            local ensure_installed = {} ---@type string[]
            for server, server_opts in pairs(servers) do
                if server_opts then
                    server_opts = server_opts == true and {} or server_opts
                    -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                    if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end

            if have_mason then
                mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
            end
        end,
    },

    -- formatters
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason.nvim" },
        opts = function()
            local nls = require("null-ls")
            return {
                root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
                sources = {
                    nls.builtins.formatting.stylua,
                    nls.builtins.formatting.shfmt,
                    nls.builtins.code_actions.gitsigns.with({
                        config = {
                            filter_actions = function(title)
                                return title:lower():match("blame") == nil -- filter out blame actions
                            end,
                        },
                    }),
                },
            }
        end,
    },

    {
        'williamboman/mason.nvim',
        cmd = "Mason",
        keys = { { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" } },
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
                "stylua",
                "bash-language-server",
                "clangd",
                "lua-language-server",
                "ltex-ls",
                "texlab",
                "shfmt",
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },

    {
        'barreiroleo/ltex_extra.nvim',
        dependencies = { "neovim/nvim-lspconfig" },
        keys = { {
            '<Leader><Leader>L',
            function()
                vim.cmd('LspStart ltex')
                -- wait for the server to start
                vim.defer_fn(function()
                    require('ltex_extra').reload()
                end, 10000)
            end,
            desc = 'Start LTeX server',
        } },
        opts = {
            load_langs = { "en-US" },
            init_check = false,
            path = ".ltex",
        },
    },
}
