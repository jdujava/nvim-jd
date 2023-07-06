-- This file is automatically loaded by plugins.core
local cmds = require('jd.cmds')
local helpers = require('jd.helpers')
local Util = require('lazy.core.util')

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
map('n', '<A-w>', '<CMD>update<CR>')
map('n', '<A-s>', '<CMD>vsp | edit #<CR>')
map('n', 'Z', '<CMD>wqa<CR>')

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

vim.keymap.set({ 'i', 'c' }, '<C-j>', '<C-n>', { remap = true })
vim.keymap.set({ 'i', 'c' }, '<C-k>', '<C-p>', { remap = true })

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

-- Delete word in insert mode
map('i', '<C-h>', '<C-w>')

-- Replace all is aliased to S
map('n', '<leader>S', ':%s/', { silent = false })
map('x', '<leader>S', ':s/', { silent = false })

-- Change perms -> Compile document -> Open document
map('n', '+x', '<CMD>!chmod +x "%:p"<CR>')
map('n', '<A-W>', '<CMD>w! | split | terminal compiler "%:p"<CR>')
map('n', '<leader>W', '<CMD>w! | !compiler "%:p"<CR>')
map('n', '<leader><leader>v', '<CMD>!opout "%:p"<CR><CR>')

-- Commands
map('n', '<leader>sw', cmds.sudo_write, { desc = 'SudoWrite' })
map('n', '<leader>x', cmds.executor, { desc = 'Executor' })
-- map('n', '<leader>x', function() helpers.R('jd.cmds').executor() end, { desc = "Executor" })
map('n', '<leader><leader>x', cmds.saveandexec, { desc = 'Save&Exec' })
map('n', '<leader>X', cmds.saveandexec, { desc = 'Save&Exec' })

-- stylua: ignore start

-- Toggle options
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
local function toggle(...) require('lazyvim.util').toggle(...) end
map('n', '<leader>uc', function() toggle('conceallevel', false, { 0, conceallevel }) end, { desc = 'Toggle Conceal' })
map('n', '<leader>uw', function() toggle('wrap') end,                                     { desc = 'Toggle Word Wrap' })
map('n', '<leader>ul', function() toggle('relativenumber', true) toggle('number') end,    { desc = 'Toggle Line Numbers' })
map('n', '<leader><leader>s', function() toggle('spell') end,                             { desc = 'Toggle Spelling' })
map('n', '<leader>ud', helpers.toggle_diagnostics,                                        { desc = 'Toggle Diagnostics' })
map('n', '<leader>uh', function() vim.lsp.inlay_hint(0, nil) end,                         { desc = 'Toggle Inlay Hints' })
map('n', '<leader>uf', function() require('lazyvim.plugins.lsp.format').toggle() end,     { desc = 'Toggle format on Save' })

-- stylua: ignore end

-- Spell-check
-- map('i', '<C-h>', '<c-g>u<Esc>[s1z=`]a<c-g>u')

-- TODO: use vim.region() when it lands... #13896 #16843
local function get_visual_selection()
    local save_a = vim.fn.getreginfo('a')
    vim.cmd([[norm! "ay]])
    local selection = vim.fn.getreg('a', 1)
    vim.fn.setreg('a', save_a)
    return selection
end
-- Opens `path` with the system default handler
-- if it fails, it tries to open it as a pdf
---@param path string
local function open(path)
    Util.info(path, { title = 'Open Link' })
    local rv = vim.ui.open(path)
    if rv and rv.code ~= 0 then
        -- Util.info('Failed to open link, trying to open as pdf', { title = 'Open Link' })
        vim.ui.open('pdf:' .. path)
    end
end
-- stylua: ignore start
map('n', '<A-~>', function() open(vim.fn.expand('<cfile>')) end, { desc = 'Open Path/Link' })
map('v', '<A-~>', function() open(get_visual_selection()) end, { desc = 'Open Path/Link' })
-- map('v', '<A-~>', 'gx', { remap = true, desc = 'Open Link' })
-- stylua: ignore end

-- Abbreviations
map('ia', '#!!', [["#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)]], { expr = true })
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
