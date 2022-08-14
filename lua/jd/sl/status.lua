local s = {}

local data    = require('jd.sl.data')
local modes   = data.modes
local builder = require('jd.sl.builder')
local lsp_status = false
-- local Path = require('plenary.path')

local TrimmedDirectory = function(dir, width)
	-- local width = vim.api.nvim_win_get_width(0)
	if #dir > width - 41 then
		-- dir = "…"..string.sub(dir,string.len(dir)+40-width,-1)
		-- dir = vim.fn.simplify(dir)
		dir = vim.fn.pathshorten(dir)
		-- dir = Path:new(dir):shorten()
	end
	return dir
end

local Get_git_status = function()
  -- use fallback because it doesn't set this variable on the initial `BufEnter`
  local signs = vim.b.gitsigns_status_dict or {head = '', added = 0, changed = 0, removed = 0}
  local is_head_empty = signs.head ~= ''

  return is_head_empty
    and string.format(
      ' +%s ~%s -%s |  %s ',
      signs.added, signs.changed, signs.removed, signs.head
    )
    or ''
end

StatusLine = function()
	local width = vim.opt.columns:get() - (vim.opt.spell:get() and 10 or 0)
	local statusline = ""
	-- Component: Mode
	local mode = vim.fn.mode()
	statusline = statusline..builder.item(modes[mode][2],modes[mode][1])

	if vim.o.spell then
		statusline = statusline..builder.item("SlFiletype","Spell")
	end

	-- Component: Working Directory
	local dir = TrimmedDirectory(vim.fn.fnamemodify(vim.fn.getcwd(), ':~'),width)
	statusline = statusline..builder.item("SlDirectory",dir)

	-- Git status
	local git_status = Get_git_status()
	if #dir + #git_status < width - 38 then
		statusline = statusline..git_status
	end


	-- Alignment to right
	statusline = statusline.."%="

	-- statusline = statusline .. git_branch.branch()

	-- LSP-STATUS
	lsp_status = require('jd.sl.lsp_status')
	if lsp_status then
		local cur_func = lsp_status.current_function()
		if #dir + #git_status + #cur_func < width - 38 then
			-- statusline = statusline.."%#Function# "..lsp_status.status()
			if string.len(cur_func) < 30 then
				statusline = statusline..cur_func.." "
			end
			-- statusline = statusline..lsp_status.server_progress().." "
			-- statusline = statusline..lsp_status.status()
		end
	end

	-- Component: FileType
	local filetype = vim.bo.filetype ~= '' and vim.bo.filetype or "none"
	statusline = statusline..builder.item("SlFiletype",filetype)

	-- Component: row and col
	local allsize = string.len(vim.api.nvim_buf_line_count(0)) -- digits of all rows
	statusline = statusline.."%#SlLine# ℓ %"..allsize.."l/%L 𝚌 %-3c"

	return statusline
end

-- s.InActiveLine = function()
-- 	-- local file_name = api.nvim_call_function('expand', {'%F'})
-- 	local file_name = "%F"
-- 	return "%#SlInActive# "..file_name
-- end
--
-- Statusline = function(mode)
-- 	return mode == "active" and s.ActiveLine() or s.InActiveLine()
-- 	-- return mode == "active" and R'jd.sl'.status.ActiveLine() or R'jd.sl'.status.InActiveLine()
-- end


return s
