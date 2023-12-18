local modes = require('simple-line.modes')
local builder = require('simple-line.builder')

local S = {}

local get_directory = function(width)
    local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
    -- if #dir > width - 41 then
    if #dir > width - 45 then
        dir = vim.fn.pathshorten(dir)
    end
    return dir
end

local function get_git_status()
    -- use fallback because it doesn't set this variable on the initial `BufEnter`
    local s = vim.b.gitsigns_status_dict or { head = '', added = 0, changed = 0, removed = 0 }
    if s.head == '' then
        return ''
    end
    return (' +%s ~%s -%s |  %s '):format(s.added, s.changed, s.removed, s.head)
end

local function search_count()
    if vim.v.hlsearch == 0 then
        return ''
    end
    -- `searchcount()` can return errors because it is evaluated very often in
    -- statusline. For example, when typing `/` followed by `\(`, it gives E54.
    local ok, s_count = pcall(vim.fn.searchcount, { recompute = true })
    if not ok or s_count.current == nil or s_count.total == 0 then
        return ''
    end

    if s_count.incomplete == 1 then
        return '[?/?] '
    end

    local too_many = ('>%d'):format(s_count.maxcount)
    local current = s_count.current > s_count.maxcount and too_many or s_count.current
    local total = s_count.total > s_count.maxcount and too_many or s_count.total
    return ('[%s/%s] '):format(current, total)
end

function S.statusLine()
    local recording = vim.fn.reg_recording()
    local width = vim.o.columns
        - (vim.o.spell and 10 or 0)
        - (vim.v.hlsearch and 8 or 0)
        - (recording ~= '' and 15 or 0)
    local statusline = ''

    -- Component: Mode
    local mode = vim.api.nvim_get_mode().mode
    statusline = statusline .. builder(modes[mode][2], modes[mode][1])

    -- Component: Spell
    if vim.o.spell then
        statusline = statusline .. builder('SlFiletype', 'Spell')
    end

    -- Component: Working Directory
    local dir = get_directory(width)
    statusline = statusline .. builder('SlDirectory', dir)

    -- Component: Git status
    local git_status = get_git_status()
    if #dir + #git_status < width - 38 then
        statusline = statusline .. git_status
    end

    -- Alignment to right
    statusline = statusline .. '%='

    -- Component: Show (partial) command
    statusline = statusline .. '%S '

    -- Component: Search count
    statusline = statusline .. search_count()

    -- Component: Show macro recording
    if recording ~= '' then
        statusline = statusline .. builder('SlRecording', 'recording @' .. recording)
    end

    -- Component: FileType
    local filetype = vim.bo.filetype ~= '' and vim.bo.filetype or 'none'
    statusline = statusline .. builder('SlFiletype', filetype)

    -- Component: row and col
    local allsize = string.len(vim.api.nvim_buf_line_count(0)) -- digits of all rows
    statusline = statusline .. '%#SlLine# ℓ %' .. allsize .. 'l/%L 𝚌 %-3c'

    return statusline
end

function S.setup()
    vim.o.laststatus = 3
    vim.o.statusline = [[%!v:lua.require'simple-line.status'.statusLine()]]
    vim.o.showcmd = true
    vim.o.showcmdloc = 'statusline'
end

return S
