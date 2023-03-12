vim.api.nvim_create_user_command(
    'SudoWrite',
    [[execute 'silent write !sudo tee % >/dev/null' | edit!]],
    {bar = true}
)


vim.cmd [[
function! Executor() abort
    if &ft == 'lua'
        exe printf(":lua %s", getline("."))
        " call execute(printf(":lua %s", getline(".")))
    elseif &ft == 'vim'
        exe getline(".")
    elseif &ft == 'sh'
        exe '!'..getline(".")
    endif
endfunction
]]

-- function _G.executor()
--  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
--  local line = vim.api.nvim_get_current_line()
--  if filetype == 'lua' then
--      print(line)
--  elseif filetype == 'vim' then
--      print(line)
--  end
-- end
-- nmap { 'asd', executor }
-- vmap { 'asd', executor }

vim.cmd [[
function! SaveandExec() abort
    if &ft == 'vim' || &ft == 'lua'
        :silent! write
        :source %
    endif
endfunction
]]
