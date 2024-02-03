return {
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        opts = {
            attach_to_untracked = true,
            -- by default fallback to the bare dotfiles repository
            worktrees = {
                {
                    toplevel = vim.env.HOME,
                    gitdir = vim.env.HOME .. '/.config/baredots',
                },
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end

                -- stylua: ignore start
                map('n', ']c',         gs.next_hunk,                                 'Git next hunk')
                map('n', '[c',         gs.prev_hunk,                                 'Git previous hunk')
                map('n', '<leader>hs', gs.stage_hunk,                                'Git stage hunk')
                map('n', '<leader>hu', gs.undo_stage_hunk,                           'Git undo stage hunk')
                map('n', '<leader>hS', gs.stage_buffer,                              'Git stage buffer')
                map('n', '<leader>hr', gs.reset_hunk,                                'Git reset hunk')
                map('n', '<leader>hR', gs.reset_buffer,                              'Git reset buffer')
                map('n', '<leader>hp', gs.preview_hunk_inline,                       'Git preview hunk (inline)')
                map('n', '<leader>hP', gs.preview_hunk,                              'Git preview hunk')
                map('n', '<leader>hd', gs.diffthis,                                  'Git diff buffer')
                map('n', '<leader>hD', gs.toggle_deleted,                            'Git toggle deleted')
                map('n', '<leader>hB', gs.toggle_current_line_blame,                 'Git toggle current line blame')
                map('n', '<leader>hb', function() gs.blame_line { full = true } end, 'Git blame line')
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>',            'Git select hunk')
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
