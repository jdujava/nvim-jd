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
                map('n', ']c',         gs.next_hunk,                                 { buffer = bufnr })
                map('n', '[c',         gs.prev_hunk,                                 { buffer = bufnr })
                map('n', '<leader>hs', gs.stage_hunk,                                { buffer = bufnr })
                map('n', '<leader>hr', gs.reset_hunk,                                { buffer = bufnr })
                map('n', '<leader>hR', gs.reset_buffer,                              { buffer = bufnr })
                map('n', '<leader>hp', gs.preview_hunk,                              { buffer = bufnr })
                map('n', '<leader>hd', gs.diffthis,                                  { buffer = bufnr })
                map('n', '<leader>hD', gs.toggle_deleted,                            { buffer = bufnr })
                map('n', '<leader>hB', gs.toggle_current_line_blame,                 { buffer = bufnr })
                map('n', '<leader>hb', function() gs.blame_line { full = true } end, { buffer = bufnr })
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>',            { buffer = bufnr })
            end,
        },
    },

    -- better diffing
    {
        'sindrets/diffview.nvim',
        cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
        keys = {
            { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'DiffView' },
            { '<leader>gf', '<cmd>DiffviewFileHistory<cr>', desc = 'DiffView File History' },
        },
        opts = {},
    },
}
