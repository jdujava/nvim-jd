vim.g.floaterm_title=''
vim.g.floaterm_borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }
vim.g.floaterm_autoinsert=1
vim.g.floaterm_width=0.85
vim.g.floaterm_height=0.85
vim.g.floaterm_autoclose=1
vim.g.floaterm_opener = 'edit'

local function lf_open(opener)
    vim.b.floaterm_opener = opener or vim.g.floaterm_opener
    vim.api.nvim_input("l")
end

nmap { '<leader>r', function()
    vim.cmd [[FloatermNew lf]]
    tmap {'<c-o>', function() lf_open()         end, {buffer=0}}
    tmap {'<c-v>', function() lf_open('vsplit') end, {buffer=0}}
    tmap {'<c-x>', function() lf_open('split')  end, {buffer=0}}
end}

nmap { '<leader>L', '<CMD>FloatermNew lazygit<CR>' }

-- automatically resize
vim.api.nvim_create_autocmd('VimResized', {
    command = [[silent FloatermUpdate]],
    group = vim.api.nvim_create_augroup("Floaterm", {}),
})

vim.api.nvim_set_hl(0, "Floaterm", {bg = "#202020"})
vim.api.nvim_set_hl(0, "FloatermBorder", {bg = "#202020"})
