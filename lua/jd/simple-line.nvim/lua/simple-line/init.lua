local M = {}

local colors = require('simple-line.colors')

function M.setup(opts)
    opts = opts or {}

    -- set highlights on first run
    colors.setStatusHi()

    -- Global Statusline and Bufferline
    vim.o.laststatus = 3
    -- vim.o.statusline = [[%!v:lua.require'simple-line.status'.statusLine()]]
    vim.o.showtabline = 2
    vim.o.tabline = [[%!v:lua.require'simple-line.buffers'.bufferLine()]]

    -- setup autocommands
    local group = vim.api.nvim_create_augroup('StatusLine', {})

    vim.api.nvim_create_autocmd('ColorScheme', {
        callback = colors.setStatusHi,
        group = group,
        desc = 'Set highlights on colorscheme change.',
    })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
        callback = function()
            vim.o.statusline = [[%!v:lua.require'simple-line.status'.statusLine()]]
        end,
        group = group,
        desc = "Setup StatusLine for all (including 'quickfix') windows.",
    })
end

return M
