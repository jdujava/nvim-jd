require("mason").setup {
    ui = {
        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = "rounded",

        icons = {
            -- The list icon to use for installed packages.
            package_installed = "✓",
            -- The list icon to use for packages that are installing, or queued for installation.
            package_pending = "➜",
            -- The list icon to use for packages that are not installed.
            package_uninstalled = "✗"
        },
    }
}

map { "<Leader>m", "<CMD>Mason<CR>" }
