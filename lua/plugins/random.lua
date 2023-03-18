return {
    {
        'github/copilot.vim',
        event = 'CursorHold',
        init = function()
            imap { '<A-l>', 'copilot#Accept("<CR>")', {expr=true, silent=true}}
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_filetypes = { TelescopePrompt = false, mail = false }
        end
    },

    {
        'kyazdani42/nvim-web-devicons',
        opts = {
            override = {
                default_icon = {
                    icon = "",
                    color = "#8b929f",
                }
            }
        }
    },

    {
        'mbbill/undotree',
        keys = {{ 'U', function()
            vim.cmd [[UndotreeToggle | UndotreeFocus]]
            vim.api.nvim_win_set_width(0, 30)
            vim.o.statusline = "%!v:lua.StatusLine()"
        end}},
        config = function()
            vim.g.undotree_WindowLayout = 2
        end
    },

    {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
        keys = {{'<A-S>', '<CMD>StartupTime --tries 10<CR>'}},
    },

    { 'tpope/vim-unimpaired', event = 'VeryLazy' },
    { 'tpope/vim-repeat', event = 'VeryLazy' },
}
