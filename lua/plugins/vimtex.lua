return {
    {
        'lervag/vimtex',
        lazy = false, -- otherwise reverse search does not work
        config = function()
            vim.g.tex_flavor = 'latex'
            vim.g.vimtex_view_method = 'zathura'
            vim.g.vimtex_view_forward_search_on_start = false
            -- vim.g.vimtex_view_method = 'sioyek'

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
            vim.g.vimtex_quickfix_ignore_filters = {
                [[You have requested package `./preamble/packages/simpler-wick/simpler-wick']],
                [[Package siunitx Warning: Detected the "physics" package]],
                [[Writing or overwriting file `robExt-remove-old-figures.py'.]],
                [[Writing or overwriting file `robExt-prepare-for-arxiv.py'.]],
            }

            vim.g.vimtex_fold_enabled = 1
            vim.g.vimtex_toc_config = {
                layer_status = { ['content'] = 1, ['label'] = 0, ['todo'] = 1, ['include'] = 0 },
                show_help = 0,
                todo_sorted = 0,
            }

            LazyVim.on_load('which-key.nvim', function()
                require('which-key').add({
                    { '<leader>l', group = 'VimTex' },
                })
            end)

            -- load local latex treesitter parser
            local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
            parser_config.latex = {
                install_info = {
                    url = vim.env.CUSTOM_SOURCE .. '/tree-sitter-latex',
                    files = { 'src/parser.c', 'src/scanner.c' },
                    requires_generate_from_grammar = true,
                },
                filetype = 'tex',
            }
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
        opts = { ensure_installed = { 'bibtex', 'latex' } },
    },

    -- Install texlab, bibtex-tidy, and ltex-ls
    {
        'williamboman/mason.nvim',
        optional = true,
        opts = { ensure_installed = { 'texlab', 'bibtex-tidy', 'ltex-ls' } },
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
                -- stylua: ignore
                formatters = {
                    latexindent = {
                        cwd = Util.root_file({ '.latexmkrc', '.git' }),
                        prepend_args = {
                            '-c', './.aux', -- location of `indent.log`
                            '-l', vim.env.XDG_CONFIG_HOME .. '/latexindent/latexindent.yaml',
                            -- '-l', vim.env.XDG_CONFIG_HOME .. '/latexindent/latexindent_MWE.yaml',
                            '-m', -- modifylinebreaks
                        },
                    },
                    ['bibtex-tidy'] = {
                        -- command = Util.find_executable({ vim.env.CUSTOM_SOURCE .. "/bibtex-tidy/bin/bibtex-tidy" }, "bibtex-tidy"),
                        prepend_args = {
                            '--space=4', '--trailing-commas',
                            -- '--sort',
                            '--sort-fields=' .. table.concat({
                                'author', 'editor', 'title', 'shorttitle', 'subtitle', 'booktitle',
                                'type', 'journal', 'on', 'publisher', 'school', 'institution', 'series',
                                'volume', 'issue', 'number', 'pages', 'year', 'month', 'day',
                                'doi', 'url', 'archiveprefix', 'primaryclass', 'eprint',
                            }, ','),
                            '--curly', '--enclosing-braces',
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
                    settings = {
                        ltex = {
                            checkFrequency = 'save',
                            latex = {
                                commands = { -- https://valentjn.github.io/ltex/settings.html#ltexlatexcommands
                                    ['\\texorpdfstring{}{}'] = 'dummy',
                                    ['\\si{}'] = 'dummy',
                                    ['\\SI{}'] = 'dummy',
                                    ['\\SI{}{}'] = 'dummy',
                                    ['\\AdS{}'] = 'dummy',
                                    ['\\CFT{}'] = 'dummy',
                                    ['\\AdSCFT{}'] = 'dummy',
                                    ['\\ldots{}'] = 'dummy',
                                    ['\\includesvg[]{}'] = 'ignore',
                                },
                                -- rules = {}, -- https://community.languagetool.org/rule/list?lang=en
                            },
                        },
                    },
                },
                texlab = {
                    -- cmd = { vim.env.CUSTOM_SOURCE .. '/texlab/target/release/texlab' },
                    keys = { -- buffer local mappings for LaTeX files
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
                        {
                            '<A-P>',
                            function()
                                local link = vim.fn.getreg('+')
                                if link:match('^%[.*%]$') then
                                    link = link:gsub('^%[(.*)%]$', '%1') -- delete [...] around
                                end
                                require('jd.helpers').ultisnips_expand('href', link)
                            end,
                            mode = { 'n', 'i' },
                            desc = 'Paste (Zathura) Link from Clipboard',
                        },
                        {
                            '<A-f>',
                            function()
                                local obj = vim.system({ 'inkscape-figure', vim.b.vimtex.root }, { text = true }):wait()
                                if obj.stdout ~= '' then
                                    -- Expand `ig` snippet (Inkscape Figure/Graphics) and insert name of the figure
                                    require('jd.helpers').ultisnips_expand('ig', obj.stdout)
                                end
                            end,
                            mode = { 'n', 'i' },
                            desc = 'Inkscape Figure',
                        },
                    },
                    settings = {
                        texlab = {
                            forwardSearch = {
                                -- https://github.com/latex-lsp/texlab/wiki/Previewing
                                executable = 'zathura',
                                args = { '--synctex-forward', '%l:1:%f', '%p' },
                            },
                            inlayHints = {
                                labelDefinitions = true,
                                labelReferences = true,
                            },
                        },
                    },
                },
            },
        },
    },

    {
        'barreiroleo/ltex_extra.nvim',
        branch = 'dev',
        ft = { 'markdown', 'tex' },
        dependencies = { 'neovim/nvim-lspconfig' },
        keys = {
            {
                '<Leader><Leader>L',
                function()
                    vim.cmd('LspStart ltex')
                end,
                desc = 'Start LTeX server',
            },
        },
        opts = {
            load_langs = { 'en-US' },
            path = '.ltex',
        },
    },
}
