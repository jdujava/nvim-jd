return {
    {
        'lervag/vimtex',
        lazy = false, -- otherwise reverse search does not work
        config = function()
            vim.g.tex_flavor = 'latex'
            vim.g.vimtex_view_method = 'zathura'

            vim.g.vimtex_matchparen_enabled = 0 -- prefer treesitter's matchparen
            vim.g.vimtex_syntax_enabled = 0 -- prefer treesitter for faster syntax highlighting and math detection
            vim.g.vimtex_syntax_conceal_disable = 1 -- also disable conceal completely
            vim.g.vimtex_imaps_enabled = 0 -- disable vimtex mappings (they don't work with treesitter anyway)
            vim.g.vimtex_imaps_leader = ';'
            vim.g.vimtex_mappings_disable = { ['n'] = { 'K' } } -- disable `K` as it conflicts with LSP hover

            vim.g.vimtex_env_toggle_math_map = { ['\\('] = '\\[', ['\\['] = 'equation', ['equation'] = '\\(' }
            vim.g.vimtex_echo_verbose_input = 0
            vim.g.vimtex_env_change_autofill = 1
            -- vim.g.vimtex_ui_method = {
            --     confirm = 'legacy',
            --     input = 'legacy',
            --     select = 'nvim',
            -- }

            vim.g.vimtex_quickfix_mode = 0
            -- vim.g.vimtex_quickfix_method = vim.fn.executable('pplatex') == 1 and 'pplatex' or 'latexlog'
            vim.g.vimtex_quickfix_ignore_filters = { [[but the package provides `simpler-wick']] }

            vim.g.vimtex_fold_enabled = 1
            vim.g.vimtex_toc_config = {
                layer_status = { ['content'] = 1, ['label'] = 0, ['todo'] = 1, ['include'] = 0 },
                show_help = 0,
                todo_sorted = 0,
            }

            require('lazyvim.util').on_load('which-key.nvim', function()
                require('which-key').register({
                    ['<leader>l'] = {
                        name = '+VimTex',
                        ['1'] = 'which_key_ignore', -- special label to hide it in the popup
                    },
                })
            end)
        end,
    },

    {
        'micangl/cmp-vimtex',
        keys = {
            {
                '<C-s>',
                function()
                    pcall(require('cmp_vimtex.search').search_menu)
                end,
                mode = 'i',
            },
        },
        opts = {},
    },

    -- Add BibTeX/LaTeX to treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        optional = true,
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { 'bibtex', 'latex' })
        end,
    },

    -- Install texlab, bibtex-tidy, and ltex-ls
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { 'texlab', 'bibtex-tidy', 'ltex-ls' })
        end,
    },

    -- Add latexindent and bibtex-tidy to conform.nvim
    {
        'stevearc/conform.nvim',
        optional = true,
        opts = function(_, opts)
            local Util = require('conform.util')
            local opts_tex = {
                formatters_by_ft = {
                    tex = { 'latexindent' },
                    bib = { 'bibtex-tidy' },
                },
                formatters = {
                    latexindent = {
                        cwd = Util.root_file({ '.latexmkrc', '.git' }),
                        prepend_args = { '-c', './.aux' },
                    },
                    -- stylua: ignore
                    ['bibtex-tidy'] = {
                        prepend_args = {
                            '--space=4', '--trailing-commas',
                            -- '--sort',
                            '--sort-fields=' .. table.concat({
                                'author', 'title', 'shorttitle', 'subtitle',
                                'journal', 'on', 'publisher', 'school', 'series',
                                'volume', 'issue', 'number', 'pages', 'year', 'month', 'day',
                                'doi', 'url', 'archiveprefix', 'primaryclass', 'eprint',
                            }, ','),
                            '--curly', '--remove-braces', '--enclosing-braces',
                        },
                    },
                },
            }
            return vim.tbl_deep_extend('force', opts, opts_tex)
        end,
    },

    -- Setup lspconfig and additional bindings for LaTeX 🚀
    {
        'neovim/nvim-lspconfig',
        optional = true,
        opts = {
            servers = {
                ltex = {
                    enabled = true,
                    autostart = false, -- manually by ltex_extra keybinding
                },
                texlab = {
                    keys = {
                        { 'gK', '<plug>(vimtex-doc-package)' },
                        { '<A-Tab>', '<plug>(vimtex-toc-open)' },
                        { 'im', '<plug>(vimtex-i$)', mode = { 'x', 'o' } },
                        { 'am', '<plug>(vimtex-a$)', mode = { 'x', 'o' } },
                        { 'dsm', '<plug>(vimtex-env-delete-math)' },
                        { 'csm', '<plug>(vimtex-env-change-math)' },
                        { 'tsm', '<plug>(vimtex-env-toggle-math)' },
                        {
                            '<leader>lf',
                            [[mc<CMD>%s/,\s*label=current//e<CR>`c$?in{frame<CR>f]i, label=current<ESC>`c]],
                            desc = 'Beamer: show only current slide/frame',
                        },
                    },
                    settings = {
                        texlab = {
                            forwardSearch = {
                                -- https://github.com/latex-lsp/texlab/wiki/Previewing
                                executable = 'zathura',
                                args = { '--synctex-forward', '%l:1:%f', '%p' },
                            },
                        },
                    },
                },
            },
        },
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
