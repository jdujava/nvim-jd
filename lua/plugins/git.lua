return {
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        opts = {
            -- by default fallback to the bare dotfiles repository
            worktrees = {
                {
                    toplevel = vim.env.HOME,
                    gitdir = vim.env.HOME .. '/.config/baredots',
                },
            },
            -- stylua: ignore
            on_attach = function(bufnr)
                local gs = require('gitsigns')
                local map = vim.keymap.set
                map('n', ']c',         gs.next_hunk,                                 { buffer = bufnr, desc = 'Git next hunk' })
                map('n', '[c',         gs.prev_hunk,                                 { buffer = bufnr, desc = 'Git previous hunk' })
                map('n', '<leader>hs', gs.stage_hunk,                                { buffer = bufnr, desc = 'Git stage hunk' })
                map('n', '<leader>hS', gs.stage_buffer,                              { buffer = bufnr, desc = 'Git stage buffer' })
                map('n', '<leader>hr', gs.reset_hunk,                                { buffer = bufnr, desc = 'Git reset hunk' })
                map('n', '<leader>hR', gs.reset_buffer,                              { buffer = bufnr, desc = 'Git reset buffer' })
                map('n', '<leader>hp', gs.preview_hunk,                              { buffer = bufnr, desc = 'Git preview hunk' })
                map('n', '<leader>hd', gs.diffthis,                                  { buffer = bufnr, desc = 'Git diff buffer' })
                map('n', '<leader>hD', gs.toggle_deleted,                            { buffer = bufnr, desc = 'Git toggle deleted' })
                map('n', '<leader>hB', gs.toggle_current_line_blame,                 { buffer = bufnr, desc = 'Git toggle current line blame' })
                map('n', '<leader>hb', function() gs.blame_line { full = true } end, { buffer = bufnr, desc = 'Git blame line' })
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>',            { buffer = bufnr, desc = 'Git select hunk' })
            end,
        },
    },

    -- better diffing
    {
        'sindrets/diffview.nvim',
        cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
        keys = {
            { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'DiffView' },
            { '<leader>gf', '<cmd>DiffviewFileHistory<cr>', desc = 'DiffView File History (whole repository)' },
            { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'DiffView File History (current file)' },
        },
        opts = function()
            local close_diffview = { 'n', '<A-x>', '<cmd>DiffviewClose<cr>', { desc = 'Close Diffview' } }
            return {
                keymaps = {
                    view = { close_diffview },
                    file_panel = { close_diffview },
                    file_history_panel = { close_diffview },
                },
            }
        end,
    },
}
