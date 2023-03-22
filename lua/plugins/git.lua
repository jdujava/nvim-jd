return {
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        opts = {
            -- signs = {
            --     add          = { text = '│' },
            --     change       = { text = '│' },
            --     delete       = { text = '_' },
            --     topdelete    = { text = '‾' },
            --     changedelete = { text = '~' },
            --     untracked    = { text = '┆' },
            -- },
            on_attach = function(bufnr)
                local gs = require("gitsigns")

                -- Navigation
                nmap { ']c', gs.next_hunk, { buffer = bufnr } }
                nmap { '[c', gs.prev_hunk, { buffer = bufnr } }

                -- Actions
                map  { '<leader>hs', gs.stage_hunk }
                map  { '<leader>hr', gs.reset_hunk }
                nmap { '<leader>hS', gs.stage_buffer }
                nmap { '<leader>hu', gs.undo_stage_hunk }
                nmap { '<leader>hR', gs.reset_buffer }
                nmap { '<leader>hp', gs.preview_hunk }
                nmap { '<leader>hb', function() gs.blame_line { full = true } end }
                nmap { '<leader>hB', gs.toggle_current_line_blame }
                nmap { '<leader>hd', gs.diffthis }
                nmap { '<leader>hD', gs.toggle_deleted }

                -- Text object
                vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { buffer = bufnr })
            end,
        }
    }
}
