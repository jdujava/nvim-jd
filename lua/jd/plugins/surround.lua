require("nvim-surround").setup({
    keymaps = {         -- Defines plugin keymaps,
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "s",
        normal_cur = "ss",
        normal_line = "S",
        normal_cur_line = "SS",
        visual = "s",
        visual_line = "S",
        delete = "ds",
        change = "cs",
    },
    -- surrounds =      -- Defines surround keys and behavior,
    -- aliases =        -- Defines aliases,
    -- highlight =      -- Defines highlight behavior,
    -- move_cursor =    -- Defines cursor behavior,
})
