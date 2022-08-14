vim.g.floaterm_title=''
vim.g.floaterm_borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }
vim.g.floaterm_autoinsert=1
vim.g.floaterm_width=0.8
vim.g.floaterm_height=0.8
vim.g.floaterm_autoclose=1
vim.g.floaterm_opener = 'edit'

local setFloatermMappings = function()
	tmap {'<c-o>', [[<cmd>let b:floaterm_opener = 'edit'   | call feedkeys("l")<CR>]], {buffer=0}}
	tmap {'<c-v>', [[<cmd>let b:floaterm_opener = 'vsplit' | call feedkeys("l")<CR>]], {buffer=0}}
	tmap {'<c-x>', [[<cmd>let b:floaterm_opener = 'split'  | call feedkeys("l")<CR>]], {buffer=0}}
 end

local FloatermMappings = vim.api.nvim_create_augroup("FloatermMappings", {clear=true})
vim.api.nvim_create_autocmd('Filetype',{
    pattern = 'floaterm',
    callback = setFloatermMappings,
    group = FloatermMappings,
})

nmap { '<leader>r', '<cmd>FloatermNew lf     <cr>' }
nmap { '<leader>L', '<cmd>FloatermNew lazygit<cr>' }
