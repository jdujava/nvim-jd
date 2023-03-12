vim.g.mapleader       = ' '
vim.g.maplocalleader  = ' '

-- handle copilot
imap { '<A-l>', 'copilot#Accept("<CR>")', {expr=true, silent=true}}
vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = { TelescopePrompt = false, mail = false }

-- Packer
nmap {'<Leader><Leader>P', function()
    R 'jd.plugins'
    require('packer').status()
end }
nmap {'<A-P>', function()
    R 'jd.plugins'
    require('packer').sync()
end }

-- open link in browser/pdf-viewer
map {'<A-~>', function()
    local link = vim.fn.expand('<cWORD>'):gsub('^%[(.*)%]$', '%1')
    -- vim.notify {link}
    vim.fn.jobstart({'xdg-open', link}, {detach = true})
end }

-- Alt maps
for _,i in ipairs{'h','j','k','l'} do
    nmap {'<A-'..i..'>',               '<C-w>'..i                         }
    nmap {'<A-'..string.upper(i)..'>', '<C-w>'..string.upper(i)           }
    tmap {'<A-'..i..'>',               '<C-\\><C-n><C-w>'..i              }
    tmap {'<A-'..string.upper(i)..'>', '<C-\\><C-n><C-w>'..string.upper(i)}
end

nmap {'<A-q>',     '<C-w>c' }
nmap {'<A-Q>',     ':wa<CR>:%bdelete<CR>' }
nmap {'<A-w>',     'mu:update<CR>`u' }
nmap {'<A-r>',     'ma:update<CR>:so $MYVIMRC<CR>`a' }
nmap {'<A-R>',     ':redraw!<CR>' }
tmap {'<A-R>',     '<C-\\><C-n>:FloatermUpdate<CR>' }
nmap {'<A-s>',     ':vsp|edit #<CR>' }
nmap {'<A-x>',     ':bd<CR>' }
tmap {'<A-x>',     '<C-\\><C-n>:bd!<CR>' }
nmap {'<A-X>',     ':edit #<CR>' }
nmap {'Z',         ':wqa<CR>' }
tmap {'<A-Esc>',   '<C-\\><C-n>' }
nmap {'<leader>t', ':split | call nvim_win_set_height(0, 12)<CR>:terminal<CR>' }

-- resizing with arrow keys
nmap {'<C-Up>',    ':resize +2<CR>' }
nmap {'<C-Down>',  ':resize -2<CR>' }
nmap {'<C-Left>',  ':vert resize +2<CR>' }
nmap {'<C-Right>', ':vert resize -2<CR>' }

imap {'<C-j>', '<C-n>', {remap=true}}
imap {'<C-k>', '<C-p>', {remap=true}}
cmap {'<C-j>', '<C-n>', {remap=true}}
cmap {'<C-k>', '<C-p>', {remap=true}}

map {'H', 'g^'}
map {'L', 'g$'}
nmap {'j', [[v:count == 0 ? "gj" : "j"]], {expr=true}}
nmap {'k', [[v:count == 0 ? "gk" : "k"]], {expr=true}}

nmap {'<C-j>',   ':move+1<cr>',         {silent=true}}
nmap {'<C-k>',   ':move-2<cr>',         {silent=true}}
nmap {'<C-h>',   '<<',                  {silent=true}}
nmap {'<C-l>',   '>>',                  {silent=true}}
xmap {'<C-k>',   [[:move-2<cr>gv=gv]],  {silent=true}}
xmap {'<C-j>',   [[:move'>+<cr>gv=gv]], {silent=true}}
xmap {'<C-h>',   '<gv',                 {silent=true}}
xmap {'<C-l>',   '>gv',                 {silent=true}}
xmap {'<',       '<gv',                 {silent=true}}
xmap {'>',       '>gv',                 {silent=true}}
xmap {'<Space>', 'I<Space><ESC>gv',     {silent=true}}

-- Swap implementations of ` and ' jump to markers
nmap { "'", "`" }
nmap { "`", "'" }

-- Operator mode
omap { "'", "i'" }
omap { '"', 'i"' }
omap { "p", "i(" }
omap { "[", "i[", {nowait=true}}
omap { "b", "i{" }

map { 'q:', '<nop>' }
map { 'q/', '<nop>' }
map { 'q?', '<nop>' }
map { '<C-z>', '<nop>' }

-- Fixed I/A for visual
xmap {'I', function()
    local mode = vim.api.nvim_get_mode().mode
    if mode == 'v' then
        return "<C-v>I"
    elseif mode == 'V' then
        return "<C-v>^o^I"
    else
        return "I"
    end
end, {expr=true}}
xmap {'A', function()
    local mode = vim.api.nvim_get_mode().mode
    if mode == 'v' then
        return "<C-v>A"
    elseif mode == 'V' then
        return "<C-v>Oo$A"
    else
        return "A"
    end
end, {expr=true}}

-- Spell-check
map  {'<Leader><Leader>s', '<Cmd>setlocal spell!<CR>', {silent=true}}
imap {'<C-h>', '<c-g>u<Esc>[s1z=`]a<c-g>u', {silent=true}}

-- Replace all is aliased to S
nmap { '<leader>S', ':%s/' }

-- Change perms -> Compile document -> Open document
nmap { '+x', '<CMD>!chmod +x "%:p"<CR>' }
nmap { '<A-W>', '<CMD>w! <bar> split <bar> terminal compiler "%:p"<CR>' }
nmap { '<leader>W', '<CMD>w! <bar> !compiler "%:p"<CR>' }
nmap { '<leader><leader>v', '<CMD>!opout "%:p"<CR><CR>' }

-- SudoWrite
nmap { '<leader>sw', '<CMD>SudoWrite<CR>' }

-- Executor
nmap { '<leader>x', '<CMD>call Executor()<CR>' }
vmap { '<leader>x', [[<CMD><C-w>exe join(getline("'<","'>"),'<Bar>')<CR>]] }
-- Save&Exec
nmap { '<leader><leader>x', '<CMD>call SaveandExec()<CR>' }
nmap { '<leader>X',         '<CMD>call SaveandExec()<CR>' }

-- Toggle hlsearch
nmap { '<A-CR>', '<CMD>let v:hlsearch=!v:hlsearch<CR>', {silent=true} }
tmap { '<A-CR>', '<C-\\><C-n><Cmd>let v:hlsearch=!v:hlsearch<CR>a', {silent=true} }

-- Show highlight group under cursor
local function name_syn_stack()
  local stack = vim.fn.synstack(vim.fn.line("."), vim.fn.col("."))
  stack = vim.tbl_map(function(v)
    return vim.fn.synIDattr(v, "name")
  end, stack)
  return stack
end

local function print_syn_group()
  local id = vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 1)
  -- print("synstack:", vim.inspect(name_syn_stack()))
  -- print(vim.fn.synIDattr(id, "name") .. " -> " .. vim.fn.synIDattr(vim.fn.synIDtrans(id), "name"))
  vim.notify("synstack:", vim.inspect(name_syn_stack()))
  vim.notify(vim.fn.synIDattr(id, "name") .. " -> " .. vim.fn.synIDattr(vim.fn.synIDtrans(id), "name"))
end
nmap { '<F10>', print_syn_group }
