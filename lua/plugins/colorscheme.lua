return {
    -- *custom* tokyonight theme
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        opts = {
            style = 'custom',
            transparent = true, -- Enable this to disable setting the background color
            terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
            styles = {
                floats = 'transparent',
                sidebars = 'transparent',
            },
            on_colors = function(c)
                local util = require('tokyonight.util')

                c.border = c.dark3
                c.bg_visual = c.dark3
                -- c.bg_float = c.bg_highlight

                c.diff = {
                    add = util.darken(c.green2, 0.35),
                    delete = util.darken(c.red1, 0.35),
                    change = util.darken(c.blue7, 0.35),
                    text = c.blue7,
                }
            end,
            on_highlights = function(hl, c)
                hl.String = { fg = c.orange }
                hl.Character = { fg = c.orange }
                hl.Function = { fg = c.yellow2 }
                hl.Operator = { fg = c.magenta }
                hl['@operator'] = { fg = c.magenta }
                hl['@parameter'] = { fg = c.yellow2 }
                hl.TreesitterContext = { bg = c.bg_context }
                hl.Search = { bg = c.dark3, underline = false }
                hl.IncSearch = { bg = c.dark4, underline = true }
                hl.MatchParen = { bg = c.dark3, bold = true }

                hl.DiagnosticUnnecessary = { link = 'DiagnosticUnderlineHint' }
                hl.DiagnosticFloatingError = { link = 'DiagnosticError' }
                hl.DiagnosticFloatingWarn = { link = 'DiagnosticWarn' }
                hl.DiagnosticFloatingInfo = { link = 'DiagnosticInfo' }
                hl.DiagnosticFloatingHint = { link = 'DiagnosticHint' }

                hl.LineNr = { fg = c.dark5 }
                hl.CursorLineNr = { fg = c.fg_dark }

                hl.Folded = { fg = c.blue, bg = '#073642' }

                -- hl.DiffAdd = { bg = c.green3 }
                -- hl.DiffChange = { bg = c.diff.change }
                hl.DiffDelete = { fg = c.dark4, bg = c.dark2 }
                -- hl.DiffText = { bg = c.diff.text }
                hl.LazyH1 = { fg = c.bg_dark, bg = c.orange }

                -- hl.TelescopeBorder = { fg = c.border_highlight, bg = c.none }
                -- hl.TelescopeNormal = { fg = c.fg, bg = c.none }
                hl.TelescopeSelection = { bg = c.bg_context, bold = true }
                hl.TelescopeSelectionCaret = { fg = c.purple, bg = c.bg_context }

                hl.CmpItemKindSnippet = { fg = c.fg_bright }
                hl.PmenuThumb = { bg = c.border_highlight }
                hl.PmenuSel = { bg = c.bg_highlight, bold = true }
                hl.FloatDarker = { fg = c.border_highlight, bg = c.bg_darker}
                hl.FloatBorder = { fg = c.border_highlight, bg = c.bg_float, blend = 0 }
                hl.FloatermBorder = { link = 'FloatBorder' }

                hl.MsgArea = { bg = c.bg_highlight }

                hl.LspInlayHint = { fg = c.dark4 }
                hl.MatchupVirtualText = { fg = c.dark5 }

                hl['@neorg.tags.ranged_verbatim.code_block'] = { bg = '#1a1a1a' }
                hl['@label.markdown'] = { link = 'NonText' }
                hl['@punctuation.delimiter.markdown'] = { link = 'NonText' }
            end,
        },
        config = function(_, opts)
            local colors = require('tokyonight.colors')

            -- create a new palette based on the default colors
            colors.custom = vim.deepcopy(colors.default)

            -- change the colors for your new palette here
            -- stylua: ignore
            colors.custom = {
                bg_darker    = '#1a1a1a',
                bg_dark      = '#1e1e1e',
                bg           = '#1e1e1e',
                dark2        = '#212121',
                bg_context   = '#262626',
                bg_highlight = '#2a2a2a',
                fg_gutter    = '#2a2a2a',
                dark3        = '#3e4452',
                dark4        = '#454e53',
                dark5        = '#5c6370',
                fg_bright    = '#F5EBD9',
                fg_dark      = '#98a8b4',
                fg           = '#abb2bf',
                purple       = '#fca7ea',
                magenta      = '#c586c0',
                magenta2     = '#934669',
                blue0        = '#569cd6',
                blue         = '#7ecbff',
                cyan         = '#7dcfff',
                blue1        = '#6bafe5',
                blue2        = '#9cdcfe',
                orange       = '#e6b089',
                yellow       = '#fbdc85',
                yellow2      = '#dcdcaa',
                green        = '#c3e88d',
                -- green1    = "#4ec9b0",
                green1       = '#89dcf4',
                green2       = '#2f563a',
                green3       = '#204533',
                teal         = '#4ec9b0',
                comment      = '#608b4e',
            }

            require('tokyonight').load(opts) -- load custom style
            -- require("tokyonight").load() -- default style

            -- require('simple-line.colors').setup() -- reload simple-line colors
        end,
    },
    -- colorizer
    {
        'NvChad/nvim-colorizer.lua',
        event = 'BufReadPre',
        keys = { { '<Leader><Leader>c', '<CMD>ColorizerToggle<CR>', desc = 'Toggle colorizer' } },
        opts = {
            filetypes = { '*', '!lazy' },
            buftype = { '*', '!prompt', '!nofile' },
            user_default_options = {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                names = false, -- "Name" codes like Blue
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                -- Available modes for `mode`: foreground, background,  virtualtext
                mode = 'background', -- Set the display mode.
            },
        },
    },
}
