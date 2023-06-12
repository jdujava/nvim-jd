local M = {}

function M.sudo_write()
    vim.cmd [[silent! write !sudo tee % >/dev/null ]]
    vim.cmd.edit { bang = true }
end

function M.term_execute(command)
    local output = vim.api.nvim_exec2("!" .. command, { output = true })
    vim.notify(output.output, vim.log.levels.INFO, { title = "Executor" })
    -- require("lazy.util").float_cmd(command)
end

function M.executor()
    local filetype = vim.bo.filetype
    local line = vim.api.nvim_get_current_line()
    if filetype == 'lua' then
        load(line)()
    elseif filetype == 'vim' then
        vim.cmd(line)
    else
        -- elseif filetype == 'sh' then
        M.term_execute(line:gsub('#', '\\#'))
    end
end

function M.saveandexec()
    vim.cmd.write()
    if vim.bo.filetype == 'lua' or vim.bo.filetype == 'vim' then
        vim.cmd.source("%")
    end
end

return M
