return {
    -- lspconfig
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'mason.nvim',
            { 'mason-org/mason-lspconfig.nvim', config = function() end },
        },
        opts_extend = { 'servers.*.keys' },
        opts = function()
            ---@class PluginLspOpts
            local ret = {
                -- options for vim.diagnostic.config()
                ---@type vim.diagnostic.Opts
                diagnostics = {
                    underline = true,
                    update_in_insert = false,
                    virtual_text = {
                        spacing = 4,
                        source = 'if_many',
                        prefix = function(diagnostic)
                            return LazyVim.opts('nvim-lspconfig').diagnostics.signs.text[diagnostic.severity]
                        end,
                    },
                    severity_sort = true,
                    signs = { text = { '', '', '', '' } },
                    float = { border = 'rounded' },
                },
                -- Enable this to enable the builtin LSP inlay hints on Neovim.
                -- Be aware that you also will need to properly configure your LSP server to
                -- provide the inlay hints.
                inlay_hints = {
                    enabled = true,
                    exclude = { 'tex' }, -- filetypes for which you don't want to enable inlay hints
                },
                -- Enable this to enable the builtin LSP code lenses on Neovim.
                -- Be aware that you also will need to properly configure your LSP server to
                -- provide the code lenses.
                codelens = {
                    enabled = false,
                },
                -- Enable this to enable the builtin LSP folding on Neovim.
                -- Be aware that you also will need to properly configure your LSP server to
                -- provide the folds.
                folds = {
                    enabled = true,
                },
                -- options for vim.lsp.buf.format
                -- `bufnr` and `filter` is handled by the LazyVim formatter,
                -- but can be also overridden when specified
                format = {
                    formatting_options = nil,
                    timeout_ms = 3000,
                },
                -- LSP Server Settings
                -- Sets the default configuration for an LSP client (or all clients if the special name "*" is used).
                ---@alias lazyvim.lsp.Config vim.lsp.Config|{mason?:boolean, enabled?:boolean, keys?:LazyKeysLspSpec[]}
                ---@type table<string, lazyvim.lsp.Config|boolean>
                servers = {
                    -- configuration for all lsp servers
                    ['*'] = {
                        capabilities = {
                            workspace = {
                                fileOperations = {
                                    didRename = true,
                                    willRename = true,
                                },
                            },
                        },
                        -- stylua: ignore
                        keys = {
                            { 'gL', function() Snacks.picker.lsp_config() end, desc = 'Lsp Info' },
                            -- { 'gL', '<cmd>LspInfo<cr>', desc = 'Lsp Info' },
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
                    },
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
                    -- lsp_wl = {
                    --     cmd = {
                    --         'WolframKernel',
                    --         '-noinit',
                    --         '-noprompt',
                    --         '-nopaclet',
                    --         '-noicon',
                    --         '-nostartuppaclets',
                    --         '-run',
                    --         'Needs["LSPServer`"]; LSPServer`StartServer[]',
                    --     },
                    --     filetypes = { 'mma', 'wl' },
                    --     root_dir = function(fname)
                    --         return require('lspconfig').util.find_git_ancestor(fname)
                    --     end,
                    -- },
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
                                codeLens = {
                                    enable = true,
                                },
                                completion = {
                                    callSnippet = 'Replace',
                                },
                                doc = {
                                    privateName = { '^_' },
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
                ---@type table<string, fun(server:string, opts: vim.lsp.Config):boolean?>
                setup = {
                    -- lsp_wl = function(_, opts)
                    --     require('lspconfig.configs').lsp_wl = { default_config = opts }
                    -- end,
                    -- example to setup with typescript.nvim
                    -- tsserver = function(_, opts)
                    --   require("typescript").setup({ server = opts })
                    --   return true
                    -- end,
                    -- Specify * to use this function as a fallback for any server
                    -- ["*"] = function(server, opts) end,
                },
            }
            return ret
        end,
        ---@param opts PluginLspOpts
        config = vim.schedule_wrap(function(_, opts)
            -- setup autoformat
            LazyVim.format.register(LazyVim.lsp.formatter())

            -- setup keymaps
            for server, server_opts in pairs(opts.servers) do
                if type(server_opts) == 'table' and server_opts.keys then
                    require('lazyvim.plugins.lsp.keymaps').set(
                        { name = server ~= '*' and server or nil },
                        server_opts.keys
                    )
                end
            end

            -- inlay hints
            if opts.inlay_hints.enabled then
                Snacks.util.lsp.on({ method = 'textDocument/inlayHint' }, function(buffer)
                    if
                        vim.api.nvim_buf_is_valid(buffer)
                        and vim.bo[buffer].buftype == ''
                        and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
                    then
                        vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
                    end
                end)
            end

            -- folds
            if opts.folds.enabled then
                Snacks.util.lsp.on({ method = 'textDocument/foldingRange' }, function()
                    if LazyVim.set_default('foldmethod', 'expr') then
                        LazyVim.set_default('foldexpr', 'v:lua.vim.lsp.foldexpr()')
                    end
                end)
            end

            -- code lens
            if opts.codelens.enabled and vim.lsp.codelens then
                Snacks.util.lsp.on({ method = 'textDocument/codeLens' }, function(buffer)
                    vim.lsp.codelens.refresh()
                    vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
                        buffer = buffer,
                        callback = vim.lsp.codelens.refresh,
                    })
                end)
            end

            -- diagnostics
            if type(opts.diagnostics.virtual_text) == 'table' and opts.diagnostics.virtual_text.prefix == 'icons' then
                opts.diagnostics.virtual_text.prefix = function(diagnostic)
                    local icons = LazyVim.config.icons.diagnostics
                    for d, icon in pairs(icons) do
                        if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                            return icon
                        end
                    end
                    return '●'
                end
            end
            vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
            require('lspconfig.ui.windows').default_options.border = 'rounded'

            if opts.capabilities then
                LazyVim.deprecate(
                    'lsp-config.opts.capabilities',
                    "Use lsp-config.opts.servers['*'].capabilities instead"
                )
                opts.servers['*'] = vim.tbl_deep_extend('force', opts.servers['*'] or {}, {
                    capabilities = opts.capabilities,
                })
            end

            if opts.servers['*'] then
                vim.lsp.config('*', opts.servers['*'])
            end

            -- get all the servers that are available through mason-lspconfig
            local have_mason = LazyVim.has('mason-lspconfig.nvim')
            local mason_all = have_mason
                    and vim.tbl_keys(require('mason-lspconfig.mappings').get_mason_map().lspconfig_to_package)
                or {} --[[ @as string[] ]]
            local mason_exclude = {} ---@type string[]

            ---@return boolean? exclude automatic setup
            local function configure(server)
                if server == '*' then
                    return false
                end
                local sopts = opts.servers[server]
                sopts = sopts == true and {} or (not sopts) and { enabled = false } or sopts --[[@as lazyvim.lsp.Config]]

                if sopts.enabled == false then
                    mason_exclude[#mason_exclude + 1] = server
                    return
                end

                local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)
                local setup = opts.setup[server] or opts.setup['*']
                if setup and setup(server, sopts) then
                    mason_exclude[#mason_exclude + 1] = server
                else
                    vim.lsp.config(server, sopts) -- configure the server
                    if not use_mason then
                        vim.lsp.enable(server)
                    end
                end
                return use_mason
            end

            local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))
            if have_mason then
                require('mason-lspconfig').setup({
                    ensure_installed = vim.list_extend(
                        install,
                        LazyVim.opts('mason-lspconfig.nvim').ensure_installed or {}
                    ),
                    automatic_enable = { exclude = mason_exclude },
                })
            end
        end),
    },

    -- cmdline tools and lsp servers
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

    {
        'stevearc/conform.nvim',
        ---@type conform.setupOpts
        opts = {
            default_format_opts = {
                timeout_ms = 8000,
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
