return {
    {
        'nvim-treesitter/nvim-treesitter',
        event = { "BufReadPost", "BufNewFile", "VeryLazy" },
        build = ":TSUpdate",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-context",
                event = "BufReadPre",
                opts = {},
            },
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        opts = {
            highlight = {
                enable = true,                -- false will disable the whole extension
                disable = { "tex", "latex" }, -- list of language that will be disabled
            },
            matchup = {
                enable = true,
            },
            indent = { enable = true },
            context_commentstring = { enable = true, enable_autocmd = false },
            ensure_installed = {
                "bash",
                "bibtex",
                "c",
                "cmake",
                -- "comment", -- comments are slowing down TS bigtime, so disable for now
                "cpp",
                "css",
                "diff",
                "git_config",
                "gitignore",
                "go",
                "vimdoc",
                "html",
                "http",
                "java",
                "javascript",
                "json",
                "latex",
                "lua",
                "luap",
                "make",
                "markdown",
                "markdown_inline",
                "meson",
                "ninja",
                "norg",
                "org",
                "passwd",
                "php",
                "python",
                "query",
                "r",
                "regex",
                "rust",
                "scss",
                "sql",
                "sxhkdrc",
                "typescript",
                "vim",
                "yaml",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = "<nop>",
                    node_decremental = "<bs>",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        -- You can optionally set descriptions to the mappings (used in the desc parameter of
                        -- nvim_buf_set_keymap) which plugins like which-key display
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        -- You can also use captures from other query groups like `locals.scm`
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                    },
                    -- You can choose the select mode (default is charwise 'v')
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V',  -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    -- include_surrounding_whitespace = true,
                },
            },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)

            require('vim.treesitter.query').set('sxhkdrc', 'injections', [[
                (command) @bash
                (comment) @comment
            ]])
        end
    },
}
