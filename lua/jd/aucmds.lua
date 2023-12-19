-- This file is automatically loaded by plugins.core
local Util = require('lazy.core.util')
local au = vim.api.nvim_create_autocmd
local function gr(name)
    return vim.api.nvim_create_augroup('jd_' .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
au({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    group = gr('checktime'),
    command = 'checktime',
})

-- Resize panes when host window is resized
au('VimResized', {
    group = gr('resize_splits'),
    command = [[wincmd =]],
})

-- Disable automatic commenting on newline
au({ 'BufNew', 'BufEnter', 'BufRead' }, {
    group = gr('formatoptions'),
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions
            + 'c' -- In general, I like it when comments respect textwidth
            - 'o' -- O and o, don't continue comments
            + 'r' -- But do continue when pressing enter.
    end,
})

au('TextYankPost', {
    group = gr('highlight_yank'),
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', on_visual = false })
    end,
})

-- Go to last loc when opening a buffer
au('BufReadPost', {
    group = gr('last_loc'),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

au('TermOpen', {
    group = gr('term_filetype'),
    pattern = 'term://*' .. vim.o.shell,
    callback = function()
        vim.bo.filetype = 'term'
        vim.o.number = false
        vim.o.relativenumber = false
        vim.o.signcolumn = 'no'
        vim.api.nvim_win_set_height(0, 12)
    end,
})
au('TermOpen', {
    group = gr('term_init'),
    callback = function()
        vim.cmd('startinsert')
        vim.keymap.set('n', '<A-x>', '<cmd>bd!<cr>', { buffer = true })
    end,
})

-- Command-line window
au('CmdwinEnter', {
    group = gr('cmdwin'),
    callback = function()
        -- vim.cmd('startinsert')
        vim.keymap.set({ 'i', 'n' }, '<A-x>', '<esc><cmd>quit<cr>', { buffer = true })
    end,
})

-- Notify start and stop of a macro recording
local macro_recording = gr('macro_recording')
au('RecordingEnter', {
    group = macro_recording,
    callback = function()
        Util.info('Started recording macro **@' .. vim.fn.reg_recording() .. '**', { title = 'Macro' })
    end,
})
au('RecordingLeave', {
    group = macro_recording,
    callback = function()
        Util.warn('Stopped recording macro **@' .. vim.fn.reg_recording() .. '**', { title = 'Macro' })
    end,
})

-- Auto updates
local group_autoupdates = gr('auto_updates')

local autoupdate = function(pattern, command)
    au('BufWritePost', {
        group = group_autoupdates,
        pattern = pattern,
        callback = function()
            require('jd.cmds').term_execute(command)
        end,
    })
end

--stylua: ignore start
autoupdate({ '*/shell/folders', 'shortcuts' }, [[shortcuts]])
autoupdate('*/st-jd/config.def.h',             [[make && sudo make install]])
autoupdate('*/nsxiv/config.def.h',             [[make && sudo make install]])
autoupdate('*/dwm-jd/dwm.c',                   [[make && sudo make install]])
autoupdate('*/slstatus-jd/config.def.h',       [[make && sudo make install && killall slstatus; setsid slstatus >/dev/null 2>&1 &]])
autoupdate('*Xresources/*',                    [[xrdb $XRESOURCES]])
autoupdate('sxhkdrc',                          [[pkill -USR1 sxhkd]])
autoupdate('dunstrc',                          [[killall dunst; setsid dunst >/dev/null 2>&1 &]])
autoupdate('*praktikum/*plot.gnu',             [[gnuplot plot.gnu > loggg.txt]])
autoupdate('fonts.conf',                       [[fc-cache]])
