local M = {}

function M.sudo_write()
    vim.cmd [[silent! write !sudo tee % >/dev/null]]
    vim.cmd [[edit!]]
end

function M.executor()
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
    local line = vim.api.nvim_get_current_line()
    if filetype == 'lua' then
        load(line)()
    elseif filetype == 'vim' then
        vim.cmd(line)
    elseif filetype == 'sh' then
        -- vim.cmd([[exe '!]]..line..[[']])
        print("Executing ["..line.."]")
        vim.cmd('split | call nvim_win_set_height(0, 12) | terminal '..line)
    end
end

function M.saveandexec()
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
    if filetype == 'lua' or 'vim' then
        vim.cmd [[silent! write]]
        vim.cmd [[source %]]
    end
end

return M
