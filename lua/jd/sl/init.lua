local M = {}

M.status = require 'jd.sl.status'
M.buffers = require 'jd.sl.buffers'
M.colors = require 'jd.sl.colors'

-- Global Statusline
vim.o.laststatus = 3
vim.o.statusline = "%!v:lua.StatusLine()"

-- Bufferline
if vim.o.showtabline ~= 0 then
    vim.o.showtabline = 2
end
vim.o.tabline = "%!v:lua.BufferLine()"

return M
