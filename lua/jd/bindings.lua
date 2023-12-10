-- This file is automatically loaded by plugins.core
local cmds = require('jd.cmds')
local helpers = require('jd.helpers')
local lazy_util = require('lazy.core.util')
local Util = require('lazyvim.util')

local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Lazy
map('n', '<A-p>', '<cmd>Lazy<cr>', { desc = 'Lazy' })
map('n', '<A-P>', '<cmd>Lazy<cr>', { desc = 'Lazy' })
map('n', '<A-r>', ':Lazy reload ', { silent = false, desc = 'Lazy reload' })

-- Alt maps
for _, i in ipairs({ 'h', 'j', 'k', 'l', 'H', 'J', 'K', 'L' }) do
    map('n', '<A-' .. i .. '>', '<C-w>' .. i)
    map('t', '<A-' .. i .. '>', '<C-\\><C-n><C-w>' .. i)
end
map('n', '<A-q>', '<C-w>c')
map('n', '<A-Q>', '<CMD>wa | %bdelete<CR>')
map('n', '<A-x>', '<CMD>bd<CR>')
map('n', '<A-X>', '<CMD>edit #<CR>')
map('n', '<A-s>', '<CMD>vsp | edit #<CR>')
map('n', 'Z', '<CMD>wqa<CR>')
map({ 'i', 'v', 'n', 's' }, '<A-w>', '<CMD>w<CR><ESC>')

-- highlights under cursor
map('n', '<leader>ui', vim.show_pos, { desc = 'Inspect Pos' })

-- Clear search with <esc>
map('n', '<esc>', '<cmd>noh<cr><esc>')

-- Add undo break-points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')

-- terminal
map('t', '<A-x>', '<CMD>bd!<CR>')
map('t', '<A-Esc>', '<C-\\><C-n>')
map('n', '<leader>t', '<CMD>split | call nvim_win_set_height(0, 12) | terminal<CR>')

-- resizing with arrow keys
map('n', '<C-Up>', '<CMD>resize +2<CR>')
map('n', '<C-Down>', '<CMD>resize -2<CR>')
map('n', '<C-Left>', '<CMD>vert resize +2<CR>')
map('n', '<C-Right>', '<CMD>vert resize -2<CR>')

-- completion with ctrl-j/k
vim.keymap.set({ 'i', 'c' }, '<C-j>', '<C-n>', { remap = true })
vim.keymap.set({ 'i', 'c' }, '<C-k>', '<C-p>', { remap = true })
vim.keymap.set('c', '<c-d>', '<Nop>')

map({ 'n', 'x', 'o' }, 'H', 'g^')
map({ 'n', 'x', 'o' }, 'L', 'g$')

map({ 'n', 'x' }, 'j', [[v:count == 0 ? "gj" : "j"]], { expr = true })
map({ 'n', 'x' }, 'k', [[v:count == 0 ? "gk" : "k"]], { expr = true })

map('n', '<C-j>', '<CMD>m .+1<CR>==')
map('n', '<C-k>', '<CMD>m .-2<CR>==')
map('x', '<C-j>', [[:move '>+1<cr>gv=gv]])
map('x', '<C-k>', [[:move '<-2<cr>gv=gv]])
map('n', '<C-h>', '<<')
map('n', '<C-l>', '>>')
map('x', '<C-h>', '<gv')
map('x', '<C-l>', '>gv')

-- Swap implementations of ` and ' jump to markers
map('n', "'", '`')
map('n', '`', "'")

-- Operator mode
map('o', "'", "i'")
map('o', '"', 'i"')
map('o', 'p', 'i(')
map('o', '[', 'i[', { nowait = true })
map('o', 'b', 'i{')

-- Fixed I/A for visual
map('x', 'I', function()
    local mode = vim.api.nvim_get_mode().mode
    if mode == 'v' then
        return '<C-v>I'
    elseif mode == 'V' then
        return '<C-v>^o^I'
    else
        return 'I'
    end
end, { expr = true, desc = 'Insert at start of line/selection' })
map('x', 'A', function()
    local mode = vim.api.nvim_get_mode().mode
    if mode == 'v' then
        return '<C-v>A'
    elseif mode == 'V' then
        return '<C-v>Oo$A'
    else
        return 'A'
    end
end, { expr = true, desc = 'Append at end of line/selection' })
map('x', '<Space>', 'I<Space><ESC>gv', { remap = true })

-- Delete word in insert/command mode with ctrl-backspace
map({ 'i', 'c' }, '<C-h>', '<C-w>', { silent = false })

-- Replace all is aliased to S
map('n', '<leader>S', ':%s/', { silent = false })
map('x', '<leader>S', ':s/', { silent = false })

-- Change perms -> Compile document -> Open document
map('n', '+x', '<CMD>!chmod +x "%:p"<CR>')
map('n', '<A-W>', function()
    vim.cmd('write')
    cmds.term_execute({ 'compiler', vim.api.nvim_buf_get_name(0) })
end, { desc = 'Save and Compile document' })
map('n', '<leader>W', '<CMD>w! | split | terminal compiler "%:p"<CR>')
-- map('n', '<leader>W', '<CMD>w! | !compiler "%:p"<CR>')
map('n', '<leader><leader>v', '<CMD>!opout "%:p"<CR><CR>', { desc = 'Open document output' })

-- Commands
map('n', '<leader>sw', cmds.sudo_write, { desc = 'SudoWrite' })
map('n', '<leader>x', cmds.executor, { desc = 'Execute current line' })
map('n', '<leader><leader>x', cmds.saveandexec, { desc = 'Save and Execute document' })
map('n', '<leader>X', cmds.saveandexec, { desc = 'Save and Execute document' })

-- Formatting
map({ 'n', 'v' }, 'gF', function()
    Util.format({ force = true })
end, { desc = 'Format' })

-- Diagnostics
local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end
map('n', '<leader>vd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
map('n', '<leader>vD', vim.diagnostic.setloclist, { desc = 'Diagnostics to LocList' })
map('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
map('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

-- stylua: ignore start

-- Toggle options
map('n', '<leader>uf', function() Util.format.toggle() end,          { desc = 'Toggle auto format (global)' })
map('n', '<leader>uF', function() Util.format.toggle(true) end,      { desc = 'Toggle auto format (buffer)' })
map('n', '<leader>uw', function() Util.toggle('wrap') end,           { desc = 'Toggle Word Wrap' })
map('n', '<leader>uL', function() Util.toggle('relativenumber') end, { desc = 'Toggle Line Numbers' })
map('n', '<leader>ul', function() Util.toggle.number() end,          { desc = 'Toggle Line Numbers' })
map('n', '<leader><leader>s', function() Util.toggle('spell') end,   { desc = 'Toggle Spelling' })
map('n', '<leader>ud', function() helpers.toggle_diagnostics() end,  { desc = 'Toggle Diagnostics' })
map('n', '<leader>uC', function() helpers.toggle_completion() end,   { desc = 'Toggle Completion' })
map('n', '<leader>ut', function() helpers.toggle_ts_highligts() end, { desc = 'Toggle Treesitter Highlight' })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 2
map('n', '<leader>uc', function() Util.toggle('conceallevel', false, { 0, conceallevel }) end, { desc = 'Toggle Conceal' })
map('n', '<leader>uh', function() Util.toggle.inlay_hints() end, { desc = 'Toggle Inlay Hints' })

-- stylua: ignore end

-- Spell-check
-- map('i', '<C-h>', '<c-g>u<Esc>[s1z=`]a<c-g>u')

-- TODO: use vim.region() when it lands... #13896 #16843
local function get_visual_selection()
    local save_a = vim.fn.getreginfo('a')
    vim.cmd([[norm! "ay]])
    local selection = vim.fn.getreg('a', 1) --[[@as string]]
    vim.fn.setreg('a', save_a)
    return selection
end
local open_desc = 'Open URI with the system default handler'
---@param uri string
local function open(uri)
    lazy_util.info(uri, { title = 'Open URI' })
    local _, err = vim.ui.open(uri)
    if err then
        lazy_util.error(err, { title = 'Open URI' })
    end
end
-- stylua: ignore start
map('n', '<A-~>', function() open(vim.fn.expand('<cfile>') --[[@as string]] ) end, { desc = open_desc })
map('v', '<A-~>', function() open(get_visual_selection()) end, { desc = open_desc })
-- map('v', '<A-~>', 'gx', { remap = true, desc = 'Open Link' })
-- stylua: ignore end

-- Abbreviations
map('ia', '#!!', [['#!/usr/bin/env ' . (empty(&filetype) ? 'sh' : &filetype)]], { expr = true })
local abbrevs = { 'E', 'Bd', 'Sp', 'Vs', 'Q', 'Q!', 'Qa', 'QA', 'QA!', 'W', 'W!', 'Wq', 'WQ', 'Wqa', 'WQa', 'WQA' }
for _, abbr in ipairs(abbrevs) do
    map('ca', abbr, abbr:lower())
end

-- Delete mappings
map('n', 'q:', '<Nop>')
map('n', 'q/', '<Nop>')
map('n', 'q?', '<Nop>')
map('c', '<C-f>', '<Nop>')
map({ 'n', 'v' }, '<C-z>', '<Nop>')
