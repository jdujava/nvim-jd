local cmds = require('jd.cmds')
local helpers = require('jd.helpers')
local R = helpers.R

vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '

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
vim.keymap.set({ 'n', 'x' }, 'j', [[v:count == 0 ? "gj" : "j"]], { expr = true } )
vim.keymap.set({ 'n', 'x' }, 'k', [[v:count == 0 ? "gk" : "k"]], { expr = true } )

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

-- Spell-check
map { '<Leader><Leader>s', '<Cmd>setlocal spell!<CR>' }
-- imap { '<C-h>', '<c-g>u<Esc>[s1z=`]a<c-g>u' }

-- Delete word in insert mode
imap { "<C-h>", "<C-w>" }

-- Replace all is aliased to S
nmap { '<leader>S', ':%s/' }

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

nmap { "<leader>ud", helpers.toggle_diagnostics, { desc = "Toggle Diagnostics" } }

-- Open link in browser/pdf-viewer
map { '<A-~>', function()
    local link = vim.fn.expand('<cWORD>'):gsub('^%[(.*)%]$', '%1')
    -- vim.notify {link}
    vim.fn.jobstart({ 'xdg-open', link }, { detach = true })
end, desc = "Open Link" }
