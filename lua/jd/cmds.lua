local Util = require('lazy.core.util')

local M = {}

function M.sudo_write()
    vim.cmd([[silent! write !sudo tee % >/dev/null ]])
    vim.cmd.edit({ bang = true })
    Util.info('File saved (as root).', { title = 'Sudo Write' })
end

function M.term_execute(command)
    local pre = '```sh\n' .. command .. '\n```\n'
    local output = ''
    local function on_data(_, data)
        output = output .. table.concat(data, '\n')
    end
    vim.fn.jobstart(command, {
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
        Util.info('File saved and sourced.', { title = 'Save&Exec' })
    end
end

return M
