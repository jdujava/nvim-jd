return {
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'j-hui/fidget.nvim',
            { 'mason-org/mason.nvim', version = '1.11.0' },
            { 'mason-org/mason-lspconfig.nvim', version = '1.32.0' },
        },
        ---@class PluginLspOpts
        opts = {
            -- options for vim.diagnostic.config()
            ---@type vim.diagnostic.Opts
            diagnostics = {
                underline = true,
                update_in_insert = false,
                signs = { text = { '', '', '', '' } },
                virtual_text = {
                    spacing = 4,
                    source = 'if_many',
                    prefix = function(diagnostic)
                        return LazyVim.opts('nvim-lspconfig').diagnostics.signs.text[diagnostic.severity]
                    end,
                },
                severity_sort = true,
                float = { border = 'rounded' },
            },
            -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
            -- Be aware that you also will need to properly configure your LSP server to
            -- provide the inlay hints.
            inlay_hints = {
                enabled = true,
                exclude = { 'tex' }, -- filetypes for which you don't want to enable inlay hints (by default)
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
                clangd = {
                    cmd = {
                        'clangd',
                        '--background-index',
                        '--clang-tidy',
                        '--header-insertion=iwyu',
                    },
                    on_init = function(client, _)
                        client.server_capabilities.semanticTokensProvider = nil
                    end,
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
                tsserver = function()
                    -- https://github.com/neovim/nvim-lspconfig/pull/3232#issuecomment-2331025714
                    return true
                end,
                -- Specify * to use this function as a fallback for any server
                -- ["*"] = function(server, opts) end,
            },
        },
        ---@param opts PluginLspOpts
        config = function(_, opts)
            -- setup autoformat
            LazyVim.format.register(LazyVim.lsp.formatter())

            -- setup keymaps
            LazyVim.lsp.on_attach(function(client, buffer)
                require('plugins.lsp.keymaps').on_attach(client, buffer)
            end)

            LazyVim.lsp.setup()
            LazyVim.lsp.on_dynamic_capability(require('plugins.lsp.keymaps').on_attach)

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

            -- inlay hints
            if opts.inlay_hints.enabled then
                LazyVim.lsp.on_attach(function(client, buffer)
                    if client:supports_method('textDocument/inlayHint') then
                        if
                            vim.api.nvim_buf_is_valid(buffer)
                            and vim.bo[buffer].buftype == ''
                            and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
                        then
                            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
                        end
                    end
                end)
            end

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
                    if server_opts.enabled ~= false then
                        -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
                        if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
                            setup(server)
                        else
                            ensure_installed[#ensure_installed + 1] = server
                        end
                    end
                end
            end

            if have_mason then
                mlsp.setup({
                    ensure_installed = vim.tbl_deep_extend(
                        'force',
                        ensure_installed,
                        LazyVim.opts('mason-lspconfig.nvim').ensure_installed or {}
                    ),
                    handlers = { setup },
                })
            end
        end,
    },

    {
        'stevearc/conform.nvim',
        ---@type conform.setupOpts
        opts = {
            default_format_opts = {
                timeout_ms = 3000,
                async = false, -- not recommended to change
                quiet = false, -- not recommended to change
                lsp_format = 'fallback', -- not recommended to change
            },
            formatters_by_ft = {
                lua = { 'stylua' },
                sh = { 'shfmt' },
                json = { 'prettier' },
                markdown = { 'prettier' },
                python = { 'black' },
                ['_'] = { 'core_fmt' }, -- split long lines and trim trailing whitespace
            },
            formatters = {
                injected = { options = { ignore_errors = true } },
                shfmt = { prepend_args = { '-i', '4', '-ci' } },
                core_fmt = { command = 'fmt', args = { '-s', '--width=90' } },
            },
        },
    },

    {
        'mason-org/mason.nvim',
        cmd = 'Mason',
        keys = { { '<leader>m', '<cmd>Mason<cr>', desc = 'Mason' } },
        build = ':MasonUpdate',
        opts_extend = { 'ensure_installed' },
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
                'lua-language-server',
                'bash-language-server',
                'clangd',
                'shfmt',
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

            mr.refresh(function()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end)
        end,
    },

    -- Properly configure LuaLS for editing NeoVim config
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        cmd = 'LazyDev',
        opts = {
            library = {
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                { path = 'LazyVim', words = { 'LazyVim' } },
                { path = 'snacks.nvim', words = { 'Snacks' } },
                { path = 'lazy.nvim', words = { 'LazyVim' } },
            },
        },
    },
    -- Add lazydev source to cmp
    {
        -- 'hrsh7th/nvim-cmp',
        'iguanacucumber/magazine.nvim', -- use magazine.nvim as upgrade of nvim-cmp
        name = 'nvim-cmp', -- call it as nvim-cmp
        opts = function(_, opts)
            table.insert(opts.sources, { name = 'lazydev', group_index = 0 })
        end,
    },
}
