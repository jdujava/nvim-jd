local s = {}

local data    = require('jd.sl.data')
local modes   = data.modes
local builder = require('jd.sl.builder')
-- local Path = require('plenary.path')
-- local lsp_status = require('jd.sl.lsp_status')

local TrimmedDirectory = function(dir)
	local width = vim.api.nvim_win_get_width(0)
	if #dir > width - 41 then
		-- dir = "…"..string.sub(dir,string.len(dir)+40-width,-1)
		-- dir = vim.fn.simplify(dir)
		dir = vim.fn.pathshorten(dir)
		-- dir = Path:new(dir):shorten()
	end
	return dir
end

s.ActiveLine = function()
	local statusline = ""
	-- Component: Mode
	local mode = vim.fn.mode()
	statusline = statusline..builder.item(modes[mode][2],modes[mode][1])

	if vim.o.spell then
		statusline = statusline..builder.item("SlFiletype","Spell")
	end

	-- Component: Working Directory
	local dir = vim.fn.fnamemodify(vim.loop.cwd(), ':~')
	statusline = statusline..builder.item("SlDirectory",TrimmedDirectory(dir))

	-- Alignment to right
	statusline = statusline.."%="

	-- LSPSTATUS
	-- if api.nvim_win_get_width(0) - string.len(dir) > 55 then
	-- 	-- statusline = statusline.."%#Function# "..lsp_status.status()
	-- 	local cur_func = lsp_status.current_function()
	-- 	if string.len(cur_func) < 30 then
	-- 		statusline = statusline.."%#Function# "..cur_func
	-- 	end
	-- 	statusline = statusline.."%#Function# "..lsp_status.server_progress(curr_buf).." "
	-- end

	-- Component: FileType
	local filetype = vim.bo.filetype ~= '' and vim.bo.filetype or "none"
	statusline = statusline..builder.item("SlFiletype",filetype)

	-- Component: row and col
	local allsize = string.len(vim.api.nvim_buf_line_count("0")) -- digits of all rows
	statusline = statusline.."%#SlLine# ℓ %"..allsize.."l/%L 𝚌 %-3c"

	return statusline
end

s.InActiveLine = function()
	-- local file_name = api.nvim_call_function('expand', {'%F'})
	local file_name = "%F"
	return "%#SlInActive# "..file_name
end

Statusline = function(mode)
	return mode == "active" and s.ActiveLine() or s.InActiveLine()
	-- return mode == "active" and R'jd.sl'.status.ActiveLine() or R'jd.sl'.status.InActiveLine()
end


return s
