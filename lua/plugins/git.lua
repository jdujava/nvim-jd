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

                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gs.nav_hunk('next')
                    end
                end, 'Next Hunk')
                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gs.nav_hunk('prev')
                    end
                end, 'Prev Hunk')

                -- stylua: ignore start
                map('n', ']C',         function() gs.nav_hunk('last') end,           'Git Last Hunk')
                map('n', '[C',         function() gs.nav_hunk('first') end,          'Git First Hunk')
                map('n', "<leader>hs", gs.stage_hunk,                                'Git Stage Hunk')
                map('n', "<leader>hr", gs.reset_hunk,                                'Git Reset Hunk')
                map('n', '<leader>hS', gs.stage_buffer,                              'Git Stage Buffer')
                map('n', '<leader>hR', gs.reset_buffer,                              'Git Reset Buffer')
                map('n', '<leader>hp', gs.preview_hunk_inline,                       'Git Preview Hunk Inline')
                map('n', '<leader>hP', gs.preview_hunk,                              'Git Preview Hunk')
                map('n', '<leader>hd', gs.diffthis,                                  'Git Diff Buffer')
                map('n', '<leader>hB', gs.blame,                                     'Git Blame')
                map('n', '<leader>hb', function() gs.blame_line { full = true } end, 'Git Blame Line')
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>',            'Git Select Hunk')
                map('v', '<leader>hs', function()
                    gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('v', '<leader>hr', function()
                    gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)
            end,
        },
    },

    -- better diffing
    {
        'sindrets/diffview.nvim',
        cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
        keys = {
            { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'DiffView' },
            { '<leader>gF', '<cmd>DiffviewFileHistory<cr>', desc = 'DiffView File History (whole repository)' },
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
