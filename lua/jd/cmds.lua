vim.api.nvim_create_user_command(
    'SudoWrite',
    [[execute 'silent write !sudo tee % >/dev/null' | edit!]],
    {bar = true}
)


-- vim.cmd [[
-- function! Executor() abort
--     if &ft == 'lua'
--         exe printf(":lua %s", getline("."))
--         " call execute(printf(":lua %s", getline(".")))
--     elseif &ft == 'vim'
--         exe getline(".")
--     elseif &ft == 'sh'
--         exe '!'..getline(".")
--     endif
-- endfunction
-- ]]

function _G.executor()
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
-- nmap { 'asd', executor }
-- vmap { 'asd', executor }
-- print("Time is " .. os.time())

-- vim.cmd [[
-- function! SaveandExec() abort
--     if &ft == 'vim' || &ft == 'lua'
--         :silent! write
--         :source %
--     endif
-- endfunction
-- ]]

function _G.saveandexec()
    local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
    if filetype == 'lua' or 'vim' then
        vim.cmd [[silent! write]]
        vim.cmd [[source %]]
    end
end
