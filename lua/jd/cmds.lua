local Util = require('lazy.core.util')

local M = {}

function M.sudo_write()
    vim.cmd([[silent! write !sudo tee % >/dev/null ]])
    vim.cmd.edit({ bang = true })
    Util.info('File saved (as root).', { title = 'Sudo Write' })
end

---@param str string
local function length_of_longest_line(str)
    local longest = 0
    for line in vim.gsplit(str, '\n') do
        longest = math.max(longest, #line)
        -- longest = math.max(longest, vim.fn.strdisplaywidth(line)) -- to properly handle tabs and wide characters
    end
    return longest
end

-- local function better_length_of_longest_line(str)
--     return math.max(unpack(vim.tbl_map(function(line)
--         return #line
--     end, vim.split(str, '\n'))))
-- end

---@param cmd string[]|string
function M.term_execute(cmd)
    local cmd_string = cmd --[[@as string]]
    if type(cmd) == 'table' then
        local s = '"' .. table.concat(cmd, '" "') .. '"'
        cmd_string = s:gsub('"([^%s]*)"', '%1') -- remove quotes around arguments with no spaces
    end
    local separator = string.rep('─', length_of_longest_line(cmd_string) + 2)
    local preamble = string.format('```sh\n%s\n%s```', cmd_string, separator)
    local output = ''
    local function on_data(_, data)
        output = output .. table.concat(data, '\n')
    end
    vim.fn.jobstart(cmd, {
        -- stdout_buffered = true,
        on_stdout = on_data,
        on_stderr = on_data,
        on_exit = function(_, code)
            local level = (code == 0) and vim.log.levels.INFO or vim.log.levels.ERROR
            if #output == 0 then
                output = '[No output of command]'
            end
            output = output .. '\n[Exit code: **' .. code .. '**]'
            Util.notify({ preamble, output }, { level = level, title = 'Executor' })
        end,
    })
end

function M.executor()
    local filetype = vim.bo.filetype
    local line = vim.api.nvim_get_current_line()
    if filetype == 'lua' then
        loadstring(line)()
    elseif filetype == 'vim' then
        vim.cmd(line)
    else
        -- try to execute as a shell command
        M.term_execute(line)
    end
end

function M.visual_executor()
    local vstart = assert(vim.fn.getpos('v'))
    local vend = assert(vim.fn.getpos('.'))
    local line_start = vstart[2]
    local line_end = vend[2]
    if line_start > line_end then
        line_start, line_end = line_end, line_start
    end
    local lines = vim.api.nvim_buf_get_lines(0, line_start - 1, line_end, true)
    local code = table.concat(lines, '\n')

    local filetype = vim.bo.filetype
    if filetype == 'lua' then
        loadstring(code)()
    else
        M.term_execute(code) -- try to execute as a shell command
    end

    return '<Esc>' -- exit the visual mode
end

function M.saveandexec()
    vim.cmd.write()
    if vim.bo.filetype == 'lua' or vim.bo.filetype == 'vim' then
        vim.cmd.source('%')
        Util.info('File saved and Sourced.', { title = 'Save&Exec' })
    end
    if vim.tbl_contains({ 'sh', 'zsh', 'bash' }, vim.bo.filetype) then
        M.term_execute(vim.api.nvim_buf_get_name(0))
        Util.info('File saved and Executed.', { title = 'Save&Exec' })
    end
end

return M
