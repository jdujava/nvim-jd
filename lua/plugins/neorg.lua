return {
    {
        "nvim-neorg/neorg",
        event = "CursorHold",
        ft = "norg",
        keys = {{'<leader>n', '<CMD>Neorg<CR>'}},
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.norg.concealer"] = {
                    config = {
                        dim_code_blocks = {
                            padding = { left = 5, right = 5},
                            width = "content",
                        },
                    },
                },
                ["core.norg.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                        default_workspace = "notes",
                    },
                },
            },
        },
        build = ":Neorg sync-parsers",
        dependencies = {'plenary.nvim'}
    }
}
