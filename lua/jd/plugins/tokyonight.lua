require("tokyonight").setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    transparent = true, -- Enable this to disable setting the background color
    terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
    },
    sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    dim_inactive = false, -- dims inactive windows

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param c ColorScheme
    on_colors = function(c)
        c.none = "NONE"
        c.bg_dark = "#1e2030"
        c.bg = "#222436"
        c.bg_highlight = "#2f334d"
        c.terminal_black = "#444a73"
        c.fg = "#c8d3f5"
        c.fg_dark = "#828bb8"
        c.fg_gutter = "#3b4261"
        c.dark3 = "#545c7e"
        c.comment = "#608b4e"
        c.dark5 = "#737aa2"
        c.blue0 = "#3e68d7"
        c.blue = "#82aaff"
        c.cyan = "#86e1fc"
        c.blue1 = "#65bcff"
        c.blue2 = "#0db9d7"
        c.blue5 = "#89ddff"
        c.blue6 = "#b4f9f8"
        c.blue7 = "#394b70"
        c.purple = "#fca7ea"
        c.magenta2 = "#ff007c"
        c.magenta = "#c099ff"
        c.orange = "#ff966c"
        c.yellow = "#ffc777"
        c.green = "#c3e88d"
        c.green1 = "#4fd6be"
        c.green2 = "#41a6b5"
        c.teal = "#4fd6be"
        c.red = "#ff757f"
        c.red1 = "#c53b53"
    end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param hl Highlights
    ---@param c ColorScheme
    on_highlights = function(hl, c)
        hl.Yank = { fg = c.none, bg = "#343434" }
    end,
})

vim.cmd.colorscheme 'tokyonight'
