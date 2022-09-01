vim.api.nvim_set_hl(0, 'IndentBlankline', {fg = '#26282a'} )
vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', {fg = '#363a3d', nocombine = true} )

require("indent_blankline").setup {
    space_char_blankline = " ",
    -- show_current_context = true,
    char_highlight_list = {
        "IndentBlankline",
    },
}
