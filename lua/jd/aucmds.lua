local au = vim.api.nvim_create_autocmd
local gr = vim.api.nvim_create_augroup

local core         = gr("core",         { clear = true })
local auto_updates = gr("auto_updates", { clear = true })
local term         = gr("term",         { clear = true })

-- Check if we need to reload the file when it changed
au({ "FocusGained", "TermClose", "TermLeave" }, {
    command = "checktime",
    group = core,
})

-- Automatically deletes all trailing whitespace on save
au('BufWritePre', {
    command = [[%s/\s\+$//e]],
    group = core,
})

-- resize panes when host window is resized
au('VimResized', {
    command = [[wincmd =]],
    group = core,
})

-- " Disables automatic commenting on newline - Commentary
au({ 'BufEnter', 'BufRead' }, {
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions
            + 'c' -- In general, I like it when comments respect textwidth
            - 'o' -- O and o, don't continue comments
            + 'r' -- But do continue when pressing enter.
    end,
    group = core,
})

au('TextYankPost', {
    callback = function()
        vim.highlight.on_yank { higroup = "Visual", on_visual = false }
    end,
    group = core,
})



-- Auto updates
local autoupdate = function(pattern, command)
    au('BufWritePost', {
        pattern = pattern,
        callback = function()
            require('jd.cmds').term_execute(command)
        end,
        group = auto_updates,
    })
end

autoupdate({'*/shell/folders', 'shortcuts'},              [[shortcuts]])
autoupdate('*/st-jd/config.def.h',                        [[make && sudo make install]])
autoupdate('*/dwm-jd/dwm.c',                              [[make && sudo make install]])
autoupdate('*/slstatus-jd/config.def.h',                  [[make && sudo make install && killall slstatus; setsid slstatus >/dev/null 2>&1 &]])
-- autoupdate('*Xresources/*',                               [[xrdb $XRESOURCES && pkill -USR1 st]])
autoupdate('*Xresources/*',                               [[xrdb $XRESOURCES]])
autoupdate('sxhkdrc',                                     [[pkill -USR1 sxhkd]])
autoupdate('dunstrc',                                     [[killall dunst; setsid dunst >/dev/null 2>&1 &]])
autoupdate({'*praktikum/*plot.gnu', '*optika/*plot.gnu'}, [[gnuplot plot.gnu > loggg.txt]])
autoupdate('fonts.conf',                                  [[fc-cache]])



au('TermOpen', {
    pattern = 'term://*',
    command = [[setfiletype term]],
    group = term,
})
au('TermOpen', {
    command = [[startinsert | nnoremap <buffer> <A-x> <CMD>bd!<CR>]],
    group = term,
})
