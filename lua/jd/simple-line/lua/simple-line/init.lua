local M = {}

function M.setup(opts)
    opts = opts or {}

    -- set highlights on first run
    require('simple-line.colors').setup()

    -- Global Statusline and Bufferline
    require('simple-line.buffers').setup()

    -- setup autocommands
    vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('simple-line_colors', {}),
        callback = require('simple-line.colors').setup,
        desc = 'Set highlights on colorscheme change.',
    })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
        group = vim.api.nvim_create_augroup('simple-line_statusline', {}),
        callback = require('simple-line.status').setup,
        desc = "Setup StatusLine for all (including 'quickfix') windows.",
    })
end

return M
