require 'jd.helpers'
require 'jd.settings'
require 'jd.bindings'
require 'jd.aucmds'
require 'jd.abbr'

-- bootstrap lazy.nvim, LazyVim and your plugins
require 'jd.lazy'

-- if false then
--     vim.o.termguicolors = true
--     vim.cmd.colorscheme 'noice'
-- else
--     local colors = require("tokyonight.colors")
--
--     -- create a new palette based on the default colors
--     colors.mystyle = vim.deepcopy(colors.default)
--
--     -- change the colors for your new palette here
--     colors.mystyle = {
--         bg = "#1e1e1e",
--         bg_dark = "#121212",
--         bg_highlight = "#2a2a2a",
--         fg = "#abb2bf",
--         comment = "#608b4e",
--         purple = "#fca7ea",
--         magenta = "#c586c0",
--         magenta2 = "#934669",
--         blue  = "#6bafe5",
--         blue1 = "#569cd6",
--         orange = "#ce9178",
--         yellow = "#dcdcaa",
--         green = "#b5cea8",
--         green1 = "#4ec9b0",
--         green2 = "#2f563a",
--         teal = "#4ec9b0",
--     }
--
--
--     -- load your style
--     require("tokyonight").load({
--         style = "mystyle",
--         transparent = true, -- Enable this to disable setting the background color
--         terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
--         styles = {
--             floats = "transparent",
--         },
--         on_colors = function(c)
--             c.border = "#3e4452"
--         end,
--         -- on_highlights = function(hl, c)
--         --     hl.WinSeparator = { fg = "#3e4452" }
--         -- end,
--     })
-- end
