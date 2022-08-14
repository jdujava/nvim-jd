local M = {}

M.status = require 'jd.sl.status'
M.buffers = require 'jd.sl.buffers'
M.colors = require 'jd.sl.colors'

nvim_create_augroups{
	Statusline = {
		[[WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline('active')]],
		[[WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline('inactive')]]
	}
}

-- Bufferline
if vim.o.showtabline ~= 0 then
	vim.o.showtabline = 2
end
vim.o.tabline = [[%!v:lua.BufferLine()]]

return M
