return {
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'j-hui/fidget.nvim',
            { 'folke/neodev.nvim', opts = true },
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        ---@class PluginLspOpts
        opts = {
            -- options for vim.diagnostic.config()
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = 'if_many',
                    -- prefix = "●",
                    prefix = 'icons',
                },
                severity_sort = true,
                float = { border = 'rounded' },
            },
            -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
            -- Be aware that you also will need to properly configure your LSP server to
            -- provide the inlay hints.
            inlay_hints = {
                enabled = true,
            },
            -- add any global capabilities here
            capabilities = {},
            -- options for vim.lsp.buf.format
            -- `bufnr` and `filter` is handled by the LazyVim formatter,
            -- but can be also overridden when specified
            format = {
                formatting_options = nil,
                timeout_ms = 3000,
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
                        'clangd',
                        '--background-index',
                        '--clang-tidy',
                        '--header-insertion=iwyu',
                    },
                },
                lua_ls = {
                    -- mason = false, -- set to false if you don't want this server to be installed with mason
                    -- Use this to add any additional keymaps
                    -- for specific lsp servers
                    ---@type LazyKeysSpec[]
                    keys = {
                        -- stylua: ignore
                        { 'K', function() require('plugins.lsp.keymaps').lua_hover() end, desc = 'NeoVim help or Lua Hover' },
                    },
                    settings = {
                        Lua = {
                            diagnostics = {
                                enable = true,
                                disable = { 'trailing-space' },
                            },
                            workspace = {
                                checkThirdParty = false,
                            },
                            hint = {
                                enable = true,
                                setType = false,
                                paramType = true,
                                paramName = 'Disable',
                                semicolon = 'Disable',
                                arrayIndex = 'Disable',
                            },
                        },
                    },
                },
            },
            -- you can do any additional lsp server setup here
            -- return true if you don't want this server to be setup with lspconfig
            ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
            setup = {
                clangd = function(_, opts)
                    opts.capabilities.offsetEncoding = { 'utf-16' }
                end,
                -- Specify * to use this function as a fallback for any server
                -- ["*"] = function(server, opts) end,
            },
        },
        ---@param opts PluginLspOpts
        config = function(_, opts)
            local Util = require('lazyvim.util')
            -- setup autoformat
            Util.format.register(Util.lsp.formatter())
            -- setup formatting and keymaps
            Util.lsp.on_attach(function(client, buffer)
                require('plugins.lsp.keymaps').on_attach(client, buffer)
            end)

            local register_capability = vim.lsp.handlers['client/registerCapability']

            vim.lsp.handlers['client/registerCapability'] = function(err, res, ctx)
                local ret = register_capability(err, res, ctx)
                local client_id = ctx.client_id
                ---@type lsp.Client
                local client = vim.lsp.get_client_by_id(client_id)
                local buffer = vim.api.nvim_get_current_buf()
                require('plugins.lsp.keymaps').on_attach(client, buffer)
                return ret
            end

            -- diagnostics
            local icons = { Error = '', Warn = '', Hint = '', Info = '' }
            for name, icon in pairs(icons) do
                name = 'DiagnosticSign' .. name
                vim.fn.sign_define(name, { text = icon, texthl = name, numhl = '' })
            end

            if opts.inlay_hints.enabled then
                Util.lsp.on_attach(function(client, buffer)
                    if client.supports_method('textDocument/inlayHint') then
                        vim.lsp.inlay_hint.enable(buffer, true)
                    end
                end)
            end

            if type(opts.diagnostics.virtual_text) == 'table' and opts.diagnostics.virtual_text.prefix == 'icons' then
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

            local servers = opts.servers
            local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
            local capabilities = vim.tbl_deep_extend(
                'force',
                {},
                vim.lsp.protocol.make_client_capabilities(),
                has_cmp and cmp_nvim_lsp.default_capabilities() or {},
                opts.capabilities or {}
            )

            local function setup(server)
                local server_opts = vim.tbl_deep_extend('force', {
                    capabilities = vim.deepcopy(capabilities),
                }, servers[server] or {})

                if opts.setup[server] then
                    if opts.setup[server](server, server_opts) then
                        return
                    end
                elseif opts.setup['*'] then
                    if opts.setup['*'](server, server_opts) then
                        return
                    end
                end
                require('lspconfig')[server].setup(server_opts)
            end

            -- get all the servers that are available through mason-lspconfig
            local have_mason, mlsp = pcall(require, 'mason-lspconfig')
            local all_mslp_servers = {}
            if have_mason then
                all_mslp_servers = vim.tbl_keys(require('mason-lspconfig.mappings.server').lspconfig_to_package)
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

    {
        'stevearc/conform.nvim',
        opts = function()
            Util = require('conform.util')
            local opts = {
                format = {
                    timeout_ms = 3000,
                    async = false, -- not recommended to change
                    quiet = false, -- not recommended to change
                },
                ---@type table<string, conform.FormatterUnit[]>
                formatters_by_ft = {
                    tex = { 'latexindent' },
                    lua = { 'stylua' },
                    sh = { 'shfmt' },
                    python = { 'black' },
                },
                ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
                formatters = {
                    injected = { options = { ignore_errors = true } },
                    latexindent = {
                        cwd = Util.root_file({ '.latexmkrc', '.git' }),
                        prepend_args = { '-c', './.aux' },
                    },
                    shfmt = { prepend_args = { '-i', '4', '-ci' } },
                    black = { prepend_args = { '--line-length', '120' } },
                },
            }
            return opts
        end,
    },

    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        keys = { { '<leader>m', '<cmd>Mason<cr>', desc = 'Mason' } },
        build = ':MasonUpdate',
        opts = {
            ui = {
                border = 'rounded',
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
            },
            ensure_installed = {
                'stylua',
                'bash-language-server',
                'clangd',
                'lua-language-server',
                'ltex-ls',
                'texlab',
                'shfmt',
                'black',
            },
        },
        ---@param opts MasonSettings | {ensure_installed: string[]}
        config = function(_, opts)
            require('mason').setup(opts)
            local mr = require('mason-registry')
            mr:on('package:install:success', function()
                vim.defer_fn(function()
                    -- trigger FileType event to possibly load this newly installed LSP server
                    require('lazy.core.handler.event').trigger({
                        event = 'FileType',
                        buf = vim.api.nvim_get_current_buf(),
                    })
                end, 100)
            end)
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
        dependencies = { 'neovim/nvim-lspconfig' },
        keys = {
            {
                '<Leader><Leader>L',
                function()
                    vim.cmd('LspStart ltex')
                    -- wait for the server to start
                    vim.defer_fn(function()
                        require('ltex_extra').reload()
                    end, 10000)
                end,
                desc = 'Start LTeX server',
            },
        },
        opts = {
            load_langs = { 'en-US' },
            init_check = false,
            path = '.ltex',
        },
    },
}
