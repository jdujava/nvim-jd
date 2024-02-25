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
                c.delta = {
                    add = util.darken(c.green2, 0.65),
                    delete = util.darken(c.red1, 0.65),
                }
            end,
            on_highlights = function(hl, c)
                local util = require('tokyonight.util')

                hl.String = { fg = c.orange }
                hl.Character = { fg = c.orange2 }
                hl.Function = { fg = c.yellow }
                hl['@variable.parameter'] = { fg = c.fg_bright }
                hl.Operator = { fg = c.magenta }
                hl['@operator'] = { fg = c.magenta }
                hl['@label.markdown'] = { link = 'NonText' }
                hl['@markup.raw.delimiter.markdown'] = { link = 'NonText' }
                hl.DiagnosticUnnecessary = { link = 'DiagnosticUnderlineHint' }

                hl.MailQuoted1 = { fg = c.comment }
                hl.MailQuoted2 = { fg = util.darken(c.teal, 0.8) }

                hl.TreesitterContext = { bg = c.bg_context }
                hl.MatchParen = { bg = c.bg_highlight, bold = true }
                hl.Search = { bg = c.dark3, underline = false }
                hl.IncSearch = { bg = c.dark4, underline = true }

                hl.Folded = { fg = c.blue, bg = c.bg_blue }
                hl.LineNr = { fg = c.dark5 }
                hl.CursorLineNr = { fg = c.fg_dark }
                hl.LspInlayHint = { fg = c.dark4 }
                hl.MatchupVirtualText = { fg = c.dark5 }
                hl.WhichKeyFloat = { bg = c.bg_darker }
                hl.VimtexPopupContent = { bg = c.bg_darker }
                hl.MsgArea = { bg = c.bg_highlight }

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
                hl.FloatDarker = { fg = c.border_highlight, bg = c.bg_darker }
                hl.FloatBorder = { fg = c.border_highlight, bg = c.bg_float, blend = 0 }
                hl.FloatermBorder = { link = 'FloatBorder' }
            end,
        },
        config = function(_, opts)
            local colors = require('tokyonight.colors')

            -- create a new palette based on the default colors
            colors.custom = vim.deepcopy(colors.default)

            -- change the colors for your new palette here
            -- stylua: ignore
            colors.custom = {
                none = "NONE",
                bg_darker    = '#1a1a1a',
                bg_dark      = '#1e1e1e',
                bg           = '#1e1e1e',
                dark2        = '#212121',
                bg_context   = '#262626',
                bg_highlight = '#2a2a2a',
                fg_gutter    = '#2a2a2a',
                bg_blue      = '#073642',
                dark3        = '#3e4452',
                dark4        = '#454e53',
                dark5        = '#5c6370',
                fg_bright    = '#f5ebd9',
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
                blue5        = "#89ddff",
                blue6        = "#b4f9f8",
                blue7        = "#394b70",
                orange       = '#e6b089',
                orange2      = '#faa069',
                yellow       = '#dcdcaa',
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

            -- -- uncomment to generate extra file for Delta
            -- local extras = {
            --     delta = { ext = 'gitconfig', url = 'https://github.com/dandavison/delta', label = 'Delta' },
            -- }
            -- local function write(str, fileName)
            --     print('[write] extra/' .. fileName)
            --     vim.fn.mkdir(vim.fs.dirname('extras/' .. fileName), 'p')
            --     local file = io.open('extras/' .. fileName, 'w')
            --     file:write(str)
            --     file:close()
            -- end
            -- for extra, info in pairs(extras) do
            --     package.loaded['tokyonight.extra.' .. extra] = nil
            --     local plugin = require('tokyonight.extra.' .. extra)
            --     local custom_colors = require('tokyonight.colors').setup({ transform = true })
            --     local fname = extra .. '/tokyonight_custom.' .. info.ext
            --     write(plugin.generate(custom_colors), fname)
            -- end
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
