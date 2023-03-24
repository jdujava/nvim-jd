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
nmap { 'j', [[v:count == 0 ? "gj" : "j"]], { expr = true } }
nmap { 'k', [[v:count == 0 ? "gk" : "k"]], { expr = true } }

nmap { '<C-j>',   '<CMD>move+1<CR>' }
nmap { '<C-k>',   '<CMD>move-2<CR>' }
xmap { '<C-k>',   [[:move-2<cr>gv=gv]],  { silent = true } }
xmap { '<C-j>',   [[:move'>+<cr>gv=gv]], { silent = true } }
nmap { '<C-h>',   '<<' }
nmap { '<C-l>',   '>>' }
xmap { '<C-h>',   '<gv' }
xmap { '<C-l>',   '>gv' }

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
        ---@diagnostic disable-next-line: undefined-field
        local mode = vim.api.nvim_get_mode().mode
        if mode == 'v' then
            return "<C-v>I"
        elseif mode == 'V' then
            return "<C-v>^o^I"
        else
            return "I"
        end
    end,
    { expr = true }
}
xmap {
    'A',
    function()
        ---@diagnostic disable-next-line: undefined-field
        local mode = vim.api.nvim_get_mode().mode
        if mode == 'v' then
            return "<C-v>A"
        elseif mode == 'V' then
            return "<C-v>Oo$A"
        else
            return "A"
        end
    end,
    { expr = true }
}
xmap { '<Space>', 'I<Space><ESC>gv', { remap = true } }

-- Spell-check
map { '<Leader><Leader>s', '<Cmd>setlocal spell!<CR>' }
imap { '<C-h>', '<c-g>u<Esc>[s1z=`]a<c-g>u' }

-- Replace all is aliased to S
nmap { '<leader>S', ':%s/' }

-- Change perms -> Compile document -> Open document
nmap { '+x', '<CMD>!chmod +x "%:p"<CR>' }
nmap { '<A-W>', '<CMD>w! | split | terminal compiler "%:p"<CR>' }
nmap { '<leader>W', '<CMD>w! | !compiler "%:p"<CR>' }
nmap { '<leader><leader>v', '<CMD>!opout "%:p"<CR><CR>' }

-- SudoWrite
nmap { '<leader>sw', function() require('jd.cmds').sudo_write() end }

-- Executor
nmap { '<leader>x', function() require('jd.cmds').executor() end }

-- Save&Exec
nmap { '<leader><leader>x', function() require('jd.cmds').saveandexec() end }
nmap { '<leader>X', function() require('jd.cmds').saveandexec() end }

-- Toggle diagnostics
nmap { "<leader>ud", require("jd.helpers").toggle_diagnostics }

-- Open link in browser/pdf-viewer
map { '<A-~>', function()
    local link = vim.fn.expand('<cWORD>'):gsub('^%[(.*)%]$', '%1')
    -- vim.notify {link}
    vim.fn.jobstart({ 'xdg-open', link }, { detach = true })
end }
