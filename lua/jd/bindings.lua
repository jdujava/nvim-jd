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

-- https://github.com/fhill2/telescope-ultisnips.nvim/issues/9
vim.keymap.set({ 'n', 'i' }, '<A-f>', function()
    local snippet = 'foo' -- should expand to 'foo bar'
    local after = vim.api.nvim_get_mode().mode == 'n'
    vim.api.nvim_put({ snippet }, '', after, true)
    vim.fn['UltiSnips#ExpandSnippet']()
    vim.cmd([[call UltiSnips#ExpandSnippet()]])
end)

-- Alt maps
for _, i in ipairs({ 'h', 'j', 'k', 'l', 'H', 'J', 'K', 'L' }) do
    map({ 'n', 't' }, '<A-' .. i .. '>', '<cmd>wincmd ' .. i .. '<cr>')
end
map({ 'n', 't' }, '<A-q>', '<cmd>close<cr>', { desc = 'Hide window' })
map('n', '<A-Q>', '<CMD>wa | %bdelete<CR>', { desc = 'Close all buffers' })
map('n', '<A-x>', '<CMD>bd<CR>', { desc = 'Close buffer' })
map('n', '<A-X>', '<CMD>edit #<CR>', { desc = 'Switch to Other Buffer' })
map('n', '<A-s>', '<CMD>vsp | edit #<CR>', { desc = 'Split and Switch to Other Buffer' })
map('n', 'Z', '<CMD>wqa<CR>', { desc = 'Save and Quit' })
map({ 'i', 'v', 'n', 's' }, '<A-w>', '<CMD>w<CR><ESC>', { desc = 'Save' })

-- highlights under cursor
map('n', '<leader>ui', vim.show_pos, { desc = 'Inspect Pos' })
map('n', '<leader>uI', '<cmd>InspectTree<cr>', { desc = 'Inspect Tree' })
map('n', ';i', ':Inspect<cr>', { desc = 'Inspect Pos', silent = false })

-- Clear search with <esc>
map('n', '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })

-- When supplied a line number, jump to it
map('n', '<cr>', "v:count == 0 ? '<CR>' : 'G'", { expr = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next search result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev search result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- Add undo break-points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')

-- terminal
map('t', '<A-x>', '<CMD>bd!<CR>', { desc = 'Close terminal buffer' })
map('t', '<A-Esc>', '<C-\\><C-n>', { desc = 'Exit to normal mode (terminal)' })
map('n', '<leader>t', '<CMD>split | terminal<CR>', { desc = 'Open Terminal (split)' })

-- resizing with arrow keys
map('n', '<C-Up>', '<CMD>resize +2<CR>', { desc = 'Resize window (vertically)' })
map('n', '<C-Down>', '<CMD>resize -2<CR>', { desc = 'Resize window (vertically)' })
map('n', '<C-Left>', '<CMD>vert resize +2<CR>', { desc = 'Resize window (horizontally)' })
map('n', '<C-Right>', '<CMD>vert resize -2<CR>', { desc = 'Resize window (horizontally)' })

-- completion with ctrl-j/k
vim.keymap.set({ 'i', 'c' }, '<C-j>', '<C-n>', { remap = true, desc = 'Next completion' })
vim.keymap.set({ 'i', 'c' }, '<C-k>', '<C-p>', { remap = true, desc = 'Prev completion' })
vim.keymap.set('c', '<c-d>', '<Nop>')

map({ 'n', 'x', 'o' }, 'H', 'g^', { desc = 'Move to the first non-blank character of line' })
map({ 'n', 'x', 'o' }, 'L', 'g$', { desc = 'Move to the last character of line' })

map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true })

map('n', '<C-j>', '<CMD>m .+1<CR>==', { desc = 'Move down' })
map('n', '<C-k>', '<CMD>m .-2<CR>==', { desc = 'Move up' })
map('x', '<C-j>', ":move '>+1<cr>gv=gv", { desc = 'Move down' })
map('x', '<C-k>', ":move '<-2<cr>gv=gv", { desc = 'Move up' })
map('n', '<C-h>', '<<', { desc = 'Move indent left' })
map('n', '<C-l>', '>>', { desc = 'Move indent right' })
map('x', '<C-h>', '<gv', { desc = 'Move indent left' })
map('x', '<C-l>', '>gv', { desc = 'Move indent right' })

-- Location and Quickfix lists
map('n', 'gl', '<cmd>lopen<cr>', { desc = 'Location List' })
map('n', 'gQ', '<cmd>copen<cr>', { desc = 'Quickfix List' })
map('n', '[l', '<cmd>lprev<cr>', { desc = 'Prev location' })
map('n', ']l', '<cmd>lnext<cr>', { desc = 'Next location' })
map('n', '[L', '<cmd>lfirst<cr>', { desc = 'First location' })
map('n', ']L', '<cmd>llast<cr>', { desc = 'Last location' })
map('n', '[q', '<cmd>cprev<cr>', { desc = 'Prev quickfix' })
map('n', ']q', '<cmd>cnext<cr>', { desc = 'Next quickfix' })
map('n', '[Q', '<cmd>cfirst<cr>', { desc = 'First quickfix' })
map('n', ']Q', '<cmd>clast<cr>', { desc = 'Last quickfix' })

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

-- Delete word in insert/command mode with <Ctrl-BackSpace>
map({ 'i', 'c' }, '<C-h>', '<C-w>', { silent = false })

-- Replace all is aliased to S
map('n', '<leader>S', ':%s/', { silent = false, desc = 'Replace all' })
map('x', '<leader>S', ':s/', { silent = false, desc = 'Replace in selection' })

-- Change perms -> Compile document -> Open document
map('n', '+x', '<CMD>!chmod +x "%:p"<CR>', { desc = 'Make file executable' })
map('n', '<A-W>', function()
    vim.cmd('write')
    cmds.term_execute({ 'compiler', vim.api.nvim_buf_get_name(0) })
end, { desc = 'Save and Compile document' })
map('n', '<leader>W', '<CMD>w! | split | terminal compiler "%:p"<CR>', { desc = 'Save and Compile document (split)' })
-- map('n', '<leader>W', '<CMD>w! | !compiler "%:p"<CR>')
map('n', '<leader><leader>v', '<CMD>!opout "%:p"<CR><CR>', { desc = 'Open document output' })

-- Commands
map('n', '<leader>sw', cmds.sudo_write, { desc = 'SudoWrite' })
map('n', '<leader>x', cmds.executor, { desc = 'Execute current line' })
map('x', '<leader>x', ':lua<cr>', { desc = 'Execute selected lines as lua' })
map('x', '<leader>so', cmds.visual_executor, { expr = true, desc = 'Execute selected lines' })
map('n', '<leader><leader>x', cmds.saveandexec, { desc = 'Save and Execute document' })
map('n', '<leader>X', cmds.saveandexec, { desc = 'Save and Execute document' })

-- Formatting
map({ 'n', 'v' }, 'gF', function()
    LazyVim.format({ force = true })
end, { desc = 'Format' })

-- Diff Mode
map('n', '<leader>dt', '<CMD>diffthis<CR>', { desc = 'Diff This' })
map('n', '<leader>do', '<CMD>diffoff<CR>', { desc = 'Diff Off' })
map('n', '<leader>dO', '<CMD>diffoff!<CR>', { desc = 'Diff Off All' })

-- Diagnostics
local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end
map('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
map('n', '<leader>dD', vim.diagnostic.setloclist, { desc = 'Diagnostics to LocList' })
map('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
map('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })
map('n', ']h', diagnostic_goto(true, 'HINT'), { desc = 'Next Hint' })
map('n', '[h', diagnostic_goto(false, 'HINT'), { desc = 'Prev Hint' })
map('n', ']i', diagnostic_goto(true, 'INFO'), { desc = 'Next Info' })
map('n', '[i', diagnostic_goto(false, 'INFO'), { desc = 'Prev Info' })

-- stylua: ignore start

-- Toggle options
LazyVim.toggle.map('<leader>uf', LazyVim.toggle.format())
LazyVim.toggle.map('<leader>uF', LazyVim.toggle.format(true))
LazyVim.toggle.map('<leader>us', LazyVim.toggle('spell', { name = 'Spelling' }))
LazyVim.toggle.map('<leader>uw', LazyVim.toggle('wrap', { name = 'Wrap' }))
LazyVim.toggle.map('<leader>uL', LazyVim.toggle('relativenumber', { name = 'Relative Number' }))
LazyVim.toggle.map('<leader>ud', helpers.toggle.diagnostics)
LazyVim.toggle.map('<leader>ul', LazyVim.toggle.number)
LazyVim.toggle.map('<leader>uc', LazyVim.toggle('conceallevel', { values = { 0, vim.o.conceallevel > 0 and vim.o.conceallevel or 2 } }))
LazyVim.toggle.map('<leader>uC', helpers.toggle.completion)
LazyVim.toggle.map('<leader>ut', LazyVim.toggle.treesitter)
LazyVim.toggle.map('<leader>uh', LazyVim.toggle.inlay_hints)
map({ 'n', 'i' }, '<A-a>', function() helpers.toggle_ultisnips_autotrigger() end, { desc = 'Toggle UltiSnips Autotrigger' })

-- stylua: ignore end

-- Spell-check
-- map('i', '<C-h>', '<c-g>u<Esc>[s1z=`]a<c-g>u')

-- NOTE: after https://github.com/neovim/neovim/commit/9762c5e3406cab8152d8dd161c0178965d841676,
--       `gx` binding is pretty good
local open_desc = 'Open URI with the system default handler'
---@param uri string|string[]|nil
local function open(uri)
    if not uri then
        return
    end
    if type(uri) == 'table' then
        return vim.tbl_map(open, uri)
    end
    Util.info(uri, { title = 'Open URI' })
    local _, err = vim.ui.open(uri)
    if err then
        Util.error(err, { title = 'Open URI' })
    end
end
map('n', '<A-~>', function()
    local isfname_orig = vim.o.isfname
    -- handle URI of the type `zathura:page:file_name.pdf`
    -- where `file_name` can include `:`, `?`, `&`, `@`, `(`, `)`
    vim.opt.isfname:append({ ':', '?', '&', '@-@', '(', ')' })
    open(vim.fn.expand('<cfile>'))
    vim.o.isfname = isfname_orig
end, { desc = open_desc })
map('v', '<A-~>', function()
    open(vim.fn.getregion(vim.fn.getpos('.'), vim.fn.getpos('v'), { type = vim.fn.mode() }))
end, { desc = open_desc })
-- map('v', '<A-~>', 'gx', { remap = true, desc = 'Open Link' })

-- Abbreviations
local abbrevs = { 'E', 'Bd', 'Sp', 'Vs', 'Q', 'Q!', 'Qa', 'QA', 'QA!', 'W', 'W!', 'Wq', 'WQ', 'Wqa', 'WQa', 'WQA' }
for _, abbr in ipairs(abbrevs) do
    map('ca', abbr, abbr:lower())
end
--  NOTE: sometimes `!` is in `iskeyword`, making the following abbreviation invalid,
--        thus throwing an error, see https://github.com/neovim/neovim/issues/27324
pcall(map, 'ia', '#!!', [['#!/usr/bin/env ' . (empty(&filetype) ? 'sh' : &filetype)]], { expr = true })

-- Disable mappings
map({ 'n', 'v' }, '<C-z>', '<Nop>', { desc = '[Disabled] Suspend NeoVim' })

map({ 'n', 'i' }, '<A-i>', function()
    Util.warn(helpers.R('jd.latex').get_zone())
    -- Util.warn(helpers.R('jd.latex').get_zone(-1))
end, { desc = 'get captures' })

-- undo autotrigger snippet (twice undo)
map('i', '<A-U>', '<CMD>undo<bar>undo<CR>', { desc = 'Undo' })
