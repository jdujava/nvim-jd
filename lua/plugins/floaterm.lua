return {
    {
        'voldikss/vim-floaterm',
        pin = true, -- pin to a specific (custom) commit
        keys = {
            {
                '<leader>r',
                function()
                    local function lf_open(opener)
                        vim.b.floaterm_opener = opener or vim.g.floaterm_opener
                        vim.api.nvim_input("l")
                    end

                    vim.cmd [[FloatermNew lf]]
                    vim.keymap.set('t', '<c-o>', function() lf_open()         end, { buffer = true })
                    vim.keymap.set('t', '<c-v>', function() lf_open('vsplit') end, { buffer = true })
                    vim.keymap.set('t', '<c-x>', function() lf_open('split')  end, { buffer = true })
                end,
                desc = 'File Manager - LF',
            },
            { '<leader>L', '<CMD>FloatermNew lazygit<CR>', desc = "LazyGit" },
        },
        config = function()
            vim.g.floaterm_title = ''
            vim.g.floaterm_borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }
            vim.g.floaterm_autoinsert = 1
            vim.g.floaterm_width = 0.85
            vim.g.floaterm_height = 0.85
            vim.g.floaterm_autoclose = 1
            vim.g.floaterm_opener = 'edit'

            -- automatically resize
            vim.api.nvim_create_autocmd('VimResized', {
                command = "silent FloatermUpdate",
                group = vim.api.nvim_create_augroup("Floaterm", {}),
            })
        end
    }
}
