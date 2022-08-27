local M = {}

M.status = require 'jd.sl.status'
M.buffers = require 'jd.sl.buffers'
M.colors = require 'jd.sl.colors'

-- Global Statusline
vim.opt.laststatus = 3
vim.opt.statusline = "%!v:lua.StatusLine()"

-- Bufferline
if vim.opt.showtabline ~= 0 then
    vim.opt.showtabline = 2
end
vim.opt.tabline = "%!v:lua.BufferLine()"

-- setup autocommands
local group = vim.api.nvim_create_augroup("StatusLine", {})

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = M.colors.setStatusHi,
    group = group,
    desc = "Set highlights on colorscheme change."
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    callback = function()
        vim.opt.statusline = "%!v:lua.StatusLine()"
    end,
    group = group,
    desc = "Same StatusLine for 'quickfix' windows."
})

return M
