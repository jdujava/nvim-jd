local c = {}

local modes = require('simple-line.modes')
local hl = vim.api.nvim_set_hl

-- Different colors for mode
local purple = '#B48EAD'
local blue   = '#61AFEF'
local yellow = '#EBCB8B'
local green  = '#4afced'
local red    = '#BF616A'

-- fg and bg
local white  = '#e6e6e6'
local black  = '#282c34'
local bg     = '#4d4d4d'

function c.MakeHi(higroup, gbg, gfg, isbold, cbg, cfg)
    hl(0, higroup, { bg=gbg, fg=gfg, bold=isbold, ctermbg=cbg, ctermfg=cfg})
    hl(0, higroup..'Separator', { bg='None', fg=gbg})
end

function c.setStatusHi()
    c.MakeHi('SlDirectory',     bg,     white, true,  0,  15)
    c.MakeHi('SlFiletype',      purple, black, true,  13, 15)
    c.MakeHi('SlLine',          'None', white, true,  15, 15)
    c.MakeHi('SlInActive',      black,  white, false, 15, 15)
    c.MakeHi('SlBufferLineSel', green,  black, true,  10, 15)
    c.MakeHi('SlBufferLine',    bg,     white, false, 15, 15)
    c.MakeHi(modes['n'][2],     green,  black, true,  10, 15)
    c.MakeHi(modes['v'][2],     purple, black, true,  13, 15)
    c.MakeHi(modes['V'][2],     purple, black, true,  13, 15)
    c.MakeHi(modes[''][2],    purple, black, true,  13, 15)
    c.MakeHi(modes['s'][2],     purple, black, true,  13, 15)
    c.MakeHi(modes[''][2],    purple, black, true,  13, 15)
    c.MakeHi(modes['i'][2],     blue,   black, true,  12, 15)
    c.MakeHi(modes['ix'][2],    blue,   black, true,  12, 15)
    c.MakeHi(modes['R'][2],     red,    black, true,  1,  15)
    c.MakeHi(modes['Rv'][2],    red,    black, true,  1,  15)
    c.MakeHi(modes['c'][2],     yellow, black, true,  11, 15)
    c.MakeHi(modes['t'][2],     red,    black, true,  1,  15)
end

return c
