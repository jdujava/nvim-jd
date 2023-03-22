return {
    -- tokyonight
    {
        "folke/tokyonight.nvim",
        lazy = false,
        opts = {
            style = "mystyle",
            transparent = true, -- Enable this to disable setting the background color
            terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
            styles = {
                floats = "transparent",
                sidebars = "transparent",
            },
            on_colors = function(c)
                c.border = c.dark3
                c.bg_visual = c.dark3
            end,
            on_highlights = function(hl, c)
                hl.String = { fg = c.orange }
                hl.Character = { fg = c.orange }
                hl.Function = { fg = c.yellow2 }
                hl.Operator = { fg = c.magenta }
                hl["@operator"] = { fg = c.magenta }
                hl["@parameter"] = { fg = c.yellow2 }
                hl.TreesitterContext = { bg = c.bg_context }
                hl.Search = { fg = "NONE", bg = c.dark4, underline = true }
                hl.IncSearch = { fg = "NONE", bg = c.dark4, underline = true }

                hl.LineNr = { fg = c.dark5 }
                hl.CursorLineNr = { fg = c.fg_dark }

                hl.Folded = { fg = c.blue, bg = "#073642" }

                -- hl.DiffAdd = { bg = c.green3 }
                -- hl.DiffChange = { bg = c.diff.change }
                hl.DiffDelete = { fg = c.dark4, bg = c.dark2 }
                -- hl.DiffText = { bg = c.diff.text }
                hl.LazyH1 = { fg = c.bg_dark, bg = c.orange }
            end,
        } ,
        config = function(_, opts)
            local colors = require("tokyonight.colors")

            -- create a new palette based on the default colors
            colors.mystyle = vim.deepcopy(colors.default)

            -- change the colors for your new palette here
            colors.mystyle = {
                bg_dark = "#121212",
                bg = "#1e1e1e",
                dark2 = "#212121",
                bg_context = "#262626",
                bg_highlight = "#2a2a2a",
                fg_gutter = "#2a2a2a",
                dark3 = "#3e4452",
                dark4 = "#454e53",
                dark5 = "#5c6370",
                fg_dark = "#98a8b4",
                fg = "#abb2bf",
                purple = "#fca7ea",
                magenta = "#c586c0",
                magenta2 = "#934669",
                blue0 = "#569cd6",
                blue  = "#7ecbff",
                cyan = "#7dcfff",
                blue1 = "#6bafe5",
                blue2 = "#9cdcfe",
                orange = "#e6b089",
                yellow = "#fbdc85",
                yellow2 = "#dcdcaa",
                green = "#c3e88d",
                -- green1 = "#4ec9b0",
                green1 = "#89dcf4",
                green2 = "#2f563a",
                green3 = "#163a2f",
                teal = "#4ec9b0",
                comment = "#608b4e",
            }

            require("tokyonight").load(opts) -- load custom style
            -- require("tokyonight").load() -- default style
        end,
    },
}
