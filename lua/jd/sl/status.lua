local modes   = require('jd.sl.modes')
local builder = require('jd.sl.builder')

local get_directory = function(width)
    local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
    if #dir > width - 41 then
        dir = vim.fn.pathshorten(dir)
    end
    return dir
end

local function get_git_status()
  -- use fallback because it doesn't set this variable on the initial `BufEnter`
  local s = vim.b.gitsigns_status_dict or {head = '', added = 0, changed = 0, removed = 0}
  if s.head == '' then
      return ''
  end
  return string.format(' +%s ~%s -%s |  %s ', s.added, s.changed, s.removed, s.head)
end

function StatusLine()
	local width = vim.opt.columns:get() - (vim.opt.spell:get() and 10 or 0)
	local statusline = ""

    -- Component: Mode
    local mode = vim.api.nvim_get_mode().mode
    statusline = statusline..builder(modes[mode][2],modes[mode][1])

    -- Component: Spell
    if vim.o.spell then
        statusline = statusline..builder("SlFiletype","Spell")
    end

    -- Component: Working Directory
    local dir = get_directory(width)
    statusline = statusline..builder("SlDirectory",dir)

	-- Component: Git status
	local git_status = get_git_status()
	if #dir + #git_status < width - 38 then
		statusline = statusline..git_status
	end

	-- Alignment to right
	statusline = statusline.."%="

    -- Component: FileType
    local filetype = vim.bo.filetype ~= '' and vim.bo.filetype or "none"
    statusline = statusline..builder("SlFiletype",filetype)

	-- Component: row and col
	local allsize = string.len(vim.api.nvim_buf_line_count(0)) -- digits of all rows
	statusline = statusline.."%#SlLine# ℓ %"..allsize.."l/%L 𝚌 %-3c"

	return statusline
end
