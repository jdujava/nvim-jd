return {
    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        opts = {
            signs = {
                add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
                change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
                delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
            },
            signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
            numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                interval = 1000,
                follow_files = true
            },
            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000,
            preview_config = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },
            yadm = {
                enable = false
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                -- Navigation
                nmap {']c', gs.next_hunk, {buffer=bufnr}}
                nmap {'[c', gs.prev_hunk, {buffer=bufnr}}

                -- Actions
                map  { '<leader>hs', ':Gitsigns stage_hunk<CR>'}
                map  { '<leader>hr', ':Gitsigns reset_hunk<CR>'}
                nmap { '<leader>hS', gs.stage_buffer}
                nmap { '<leader>hu', gs.undo_stage_hunk}
                nmap { '<leader>hR', gs.reset_buffer}
                nmap { '<leader>hp', gs.preview_hunk}
                nmap { '<leader>hb', function() gs.blame_line{full=true} end}
                nmap { '<leader>tb', gs.toggle_current_line_blame}
                nmap { '<leader>hd', gs.diffthis}
                nmap { '<leader>hD', function() gs.diffthis('~') end}
                nmap { '<leader>td', gs.toggle_deleted}

                -- Text object
                vim.keymap.set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {buffer=bufnr})
            end,
        }
    }
}
