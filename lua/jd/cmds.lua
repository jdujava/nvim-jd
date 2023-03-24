local M = {}

function M.sudo_write()
    vim.cmd [[silent! write !sudo tee % >/dev/null ]]
    vim.cmd.edit { bang = true }
end

function M.term_execute(command)
    print("Executing [" .. command .. "]")
    -- sleep needed to avoid discarding the first line of output
    vim.cmd('split | call nvim_win_set_height(0, 12) | terminal sleep 0.05;' .. command)
end

function M.executor()
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
    local line = vim.api.nvim_get_current_line()
    if filetype == 'lua' then
        load(line)()
    elseif filetype == 'vim' then
        vim.cmd(line)
    elseif filetype == 'sh' then
        M.term_execute(line)
    end
end

function M.saveandexec()
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
    if filetype == 'lua' or 'vim' then
        vim.cmd.write()
        vim.cmd.source("%")
    end
end

return M
