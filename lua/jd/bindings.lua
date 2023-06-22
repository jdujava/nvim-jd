local cmds = require('jd.cmds')
local helpers = require('jd.helpers')
local R = helpers.R

-- Alt maps
for _, i in ipairs{'h','j','k','l','H','J','K','L'} do
    nmap {'<A-'..i..'>', '<C-w>'..i }
    tmap {'<A-'..i..'>', '<C-\\><C-n><C-w>'..i }
end
nmap { '<A-q>', '<C-w>c' }
nmap { '<A-Q>', '<CMD>wa | %bdelete<CR>' }
nmap { '<A-x>', '<CMD>bd<CR>' }
nmap { '<A-X>', '<CMD>edit #<CR>' }
nmap { '<A-w>', '<CMD>update<CR>' }
nmap { '<A-s>', '<CMD>vsp | edit #<CR>' }
nmap { 'Z',     '<CMD>wqa<CR>' }

-- Clear search with <esc>
nmap { "<esc>", "<cmd>noh<cr><esc>" }

-- Add undo break-points
imap { ",", ",<c-g>u" }
imap { ".", ".<c-g>u" }
imap { ";", ";<c-g>u" }

-- terminal
tmap { '<A-x>',     '<CMD>bd!<CR>' }
tmap { '<A-Esc>',   '<C-\\><C-n>' }
nmap { '<leader>t', '<CMD>split | call nvim_win_set_height(0, 12) | terminal<CR>' }

-- resizing with arrow keys
nmap { '<C-Up>',    '<CMD>resize +2<CR>', }
nmap { '<C-Down>',  '<CMD>resize -2<CR>', }
nmap { '<C-Left>',  '<CMD>vert resize +2<CR>', }
nmap { '<C-Right>', '<CMD>vert resize -2<CR>', }

vim.keymap.set({ 'i', 'c' }, '<C-j>', '<C-n>', { remap = true })
vim.keymap.set({ 'i', 'c' }, '<C-k>', '<C-p>', { remap = true })

map { 'H', 'g^' }
map { 'L', 'g$' }
vim.keymap.set({ 'n', 'x' }, 'j', [[v:count == 0 ? "gj" : "j"]], { expr = true })
vim.keymap.set({ 'n', 'x' }, 'k', [[v:count == 0 ? "gk" : "k"]], { expr = true })

nmap { '<C-j>', '<CMD>m .+1<CR>==' }
nmap { '<C-k>', '<CMD>m .-2<CR>==' }
xmap { '<C-j>', [[:move '>+1<cr>gv=gv]], { silent = true } }
xmap { '<C-k>', [[:move '<-2<cr>gv=gv]], { silent = true } }
nmap { '<C-h>', '<<' }
nmap { '<C-l>', '>>' }
xmap { '<C-h>', '<gv' }
xmap { '<C-l>', '>gv' }

-- Swap implementations of ` and ' jump to markers
nmap { "'", "`" }
nmap { "`", "'" }

-- Operator mode
omap { "'", "i'" }
omap { '"', 'i"' }
omap { "p", "i(" }
omap { "[", "i[", { nowait = true } }
omap { "b", "i{" }

map { 'q:', '<nop>' }
map { 'q/', '<nop>' }
map { 'q?', '<nop>' }
map { '<C-z>', '<nop>' }

-- Fixed I/A for visual
xmap {
    'I',
    function()
        local mode = vim.api.nvim_get_mode().mode
        if mode == 'v' then
            return "<C-v>I"
        elseif mode == 'V' then
            return "<C-v>^o^I"
        else
            return "I"
        end
    end,
    { expr = true, desc = "Insert at start of line/selection" }
}
xmap {
    'A',
    function()
        local mode = vim.api.nvim_get_mode().mode
        if mode == 'v' then
            return "<C-v>A"
        elseif mode == 'V' then
            return "<C-v>Oo$A"
        else
            return "A"
        end
    end,
    { expr = true, desc = "Append at end of line/selection" }
}
xmap { '<Space>', 'I<Space><ESC>gv', { remap = true } }

-- Delete word in insert mode
imap { "<C-h>", "<C-w>" }

-- Replace all is aliased to S
nmap { '<leader>S', ':%s/' }
vmap { '<leader>S', ':s/' }

-- Change perms -> Compile document -> Open document
nmap { '+x', '<CMD>!chmod +x "%:p"<CR>' }
nmap { '<A-W>', '<CMD>w! | split | terminal compiler "%:p"<CR>' }
nmap { '<leader>W', '<CMD>w! | !compiler "%:p"<CR>' }
nmap { '<leader><leader>v', '<CMD>!opout "%:p"<CR><CR>' }

nmap { '<leader>sw', cmds.sudo_write, { desc = "SudoWrite" } }
nmap { '<leader>x', cmds.executor, { desc = "Executor" } }
-- nmap { '<leader>x', function() R('jd.cmds').executor() end, { desc = "Executor" } }
nmap { '<leader><leader>x', cmds.saveandexec, { desc = "Save&Exec" } }
nmap { '<leader>X', cmds.saveandexec, { desc = "Save&Exec" } }

-- Toggle options
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
nmap { "<leader>uc", function() helpers.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" } }
nmap { "<leader>uw", function() helpers.toggle("wrap") end, { desc = "Toggle Word Wrap" } }
nmap { "<leader>ul", function() helpers.toggle("relativenumber", true) helpers.toggle("number") end, { desc = "Toggle Line Numbers" } }
nmap { "<leader><leader>s", function() helpers.toggle("spell") end, { desc = "Toggle Spelling" } }
nmap { "<leader>ud", helpers.toggle_diagnostics, { desc = "Toggle Diagnostics" } }
nmap { "<leader>uh", function() vim.lsp.buf.inlay_hint(0, nil) end, { desc = "Toggle Inlay Hints" } }
nmap { "<leader>uf", require("plugins.lsp.format").toggle, { desc = "Toggle format on Save" } }

-- Spell-check
-- imap { '<C-h>', '<c-g>u<Esc>[s1z=`]a<c-g>u' }

-- Open link in browser/pdf-viewer
map { '<A-~>', function()
    local link = vim.fn.expand('<cWORD>'):gsub('^%[(.*)%]$', '%1')
    -- vim.notify {link}
    vim.fn.jobstart({ 'xdg-open', link }, { detach = true })
end, desc = "Open Link" }

-- Abbreviations
iamap { '#!!', [["#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)]], { expr = true } }
camap { 'Bd', 'bd' }
camap { 'Cp', 'cp' }
camap { 'E', 'e' }
camap { 'Sp', 'sp' }
camap { 'SP', 'sp' }
camap { 'Vs', 'vs' }
camap { 'VS', 'vs' }
camap { 'Q', 'q' }
camap { 'Q!', 'q!' }
camap { 'Qa', 'qa' }
camap { 'QA', 'qa' }
camap { 'QA!', 'qa!' }
camap { 'W', 'w' }
camap { 'W!', 'w!' }
camap { 'Wq', 'wq' }
camap { 'WQ', 'wq' }
camap { 'Wqa', 'wqa' }
camap { 'WQa', 'wqa' }
camap { 'WQA', 'wqa' }
