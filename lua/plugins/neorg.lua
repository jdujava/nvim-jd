return {
    {
        "nvim-neorg/neorg",
        event = "VeryLazy",
        ft = "norg",
        keys = { { '<leader>n', '<CMD>Neorg<CR>', desc = 'Neorg' } },
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {
                    config = {
                        dim_code_blocks = {
                            conceal = false,
                            padding = { left = 5, right = 5 },
                            width = "content",
                        },
                    },
                },
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/Documents/Notes/",
                        },
                        default_workspace = "notes",
                    },
                },
                ["core.completion"] = { config = { engine = "nvim-cmp" } },
                ["core.integrations.nvim-cmp"] = {},
            },
        },
        build = ":Neorg sync-parsers",
        dependencies = { 'plenary.nvim' }
    }
}
