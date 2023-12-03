local Util = require('lazy.core.util')

local M = {}

function M.sudo_write()
    vim.cmd([[silent! write !sudo tee % >/dev/null ]])
    vim.cmd.edit({ bang = true })
    Util.info('File saved (as root).', { title = 'Sudo Write' })
end

---@param cmd string[]|string
function M.term_execute(cmd)
    local cmd_string = cmd
    if type(cmd) == 'table' then
        local s = '"' .. table.concat(cmd, '" "') .. '"'
        cmd_string = s:gsub('"([^%s]*)"', '%1') -- remove quotes around arguments with no spaces
    end
    local pre = string.format('```sh\n%s\n```\n', cmd_string)
    local output = ''
    local function on_data(_, data)
        output = output .. table.concat(data, '\n')
    end
    vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        on_stdout = on_data,
        on_stderr = on_data,
        on_exit = function(_, code)
            local level = (code == 0) and vim.log.levels.INFO or vim.log.levels.ERROR
            if #output == 0 then
                output = '[No output of command]'
            end
            output = output .. '\n[Exit code: **' .. code .. '**]'
            Util.notify({ pre, output }, { level = level, title = 'Executor' })
        end,
    })
end

function M.executor()
    local filetype = vim.bo.filetype
    local line = vim.api.nvim_get_current_line()
    if filetype == 'lua' then
        load(line)()
    elseif filetype == 'vim' then
        vim.cmd(line)
    else
        -- try to execute as a shell command
        M.term_execute(line)
    end
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
