TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
    local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

    TelescopeMapArgs[map_key] = options or {}

    local mode = "n"
    local rhs = function() require('plugins.telescope.setup')[f](TelescopeMapArgs[map_key]) end

    local opts = { silent = true }
    if buffer then
        opts.buffer = 0
    end

    vim.keymap.set(mode, key, rhs, opts)
end

cmap {"<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", {nowait=true}}

-- Dotfiles
map_tele("<leader>en", "edit_neovim")
map_tele("<leader>ez", "edit_zsh")
map_tele("<leader>ei", "installed_plugins")
map_tele("<leader>em", "my_plugins")

map_tele("<leader><leader>f", "find_files")
map_tele("<leader>f", "search_all_files")
map_tele("<leader>R", "reloader")
map_tele("<leader>b", "buffers")
map_tele("<leader>B", "builtin")
map_tele("<leader>g", "live_grep")
map_tele("<leader>F", "oldfiles")
map_tele("<leader>c", "curbuf")
map_tele("<leader>C", "commands")
map_tele("<leader>O", "vim_options")
map_tele("<leader>K", "keymaps")
map_tele("<leader>M", "messages")
map_tele("<leader><leader>M", "man_pages")
map_tele("<leader>H", "help_tags")
map_tele("<leader>N", "notify")

map_tele("<A-Tab>", "ultisnips")

map_tele("<leader>p", "project_search")
map_tele("<leader>/", "search_history")

return map_tele
