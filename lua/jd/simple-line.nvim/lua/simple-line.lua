local M = {}

M.status = require('simple-line.status')
M.buffers = require('simple-line.buffers')
M.colors = require('simple-line.colors')

function M.setup(user_config)
    -- set highlights on first run
    M.colors.setStatusHi()

    -- Global Statusline
    vim.o.laststatus = 3
    -- vim.o.statusline = "%!v:lua.StatusLine()"

    -- Bufferline
    if vim.o.showtabline ~= 0 then
        vim.o.showtabline = 2
    end
    vim.o.tabline = "%!v:lua.BufferLine()"

    -- setup autocommands
    local group = vim.api.nvim_create_augroup("StatusLine", {})

    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = M.colors.setStatusHi,
        group = group,
        desc = "Set highlights on colorscheme change."
    })

    vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
        callback = function()
            vim.o.statusline = "%!v:lua.StatusLine()"
        end,
        group = group,
        desc = "Setup StatusLine for all (including 'quickfix') windows."
    })

end

return M
