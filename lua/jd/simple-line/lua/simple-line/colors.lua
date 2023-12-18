local C = {}

local modes = require('simple-line.modes')
local hl = vim.api.nvim_set_hl

-- Different colors for mode
-- stylua: ignore
C.col = {
    white  = '#e6e6e6',
    black  = '#282c34',
    bg     = '#4d4d4d',
    purple = '#B48EAD',
    blue   = '#61AFEF',
    yellow = '#EBCB8B',
    green  = '#4afced',
    red    = '#BF616A',
    none   = 'None',
}

function C.MakeHi(higroup, gbg, gfg, isbold, cbg, cfg)
    hl(0, higroup, { bg = gbg, fg = gfg, bold = isbold, ctermbg = cbg, ctermfg = cfg })
    hl(0, higroup .. 'Separator', { bg = 'None', fg = gbg })
end

-- stylua: ignore
function C.setup()
    C.MakeHi('SlDirectory',     C.col.bg,     C.col.white, true,  0,  15)
    C.MakeHi('SlFiletype',      C.col.purple, C.col.black, true,  13, 15)
    C.MakeHi('SlRecording',     C.col.yellow, C.col.black, true,  13, 15)
    C.MakeHi('SlLine',          C.col.none,   C.col.white, true,  15, 15)
    C.MakeHi('SlInActive',      C.col.black,  C.col.white, false, 15, 15)
    C.MakeHi('SlBufferLineSel', C.col.green,  C.col.black, true,  10, 15)
    C.MakeHi('SlBufferLine',    C.col.bg,     C.col.white, false, 15, 15)
    C.MakeHi(modes['n'][2],     C.col.green,  C.col.black, true,  10, 15)
    C.MakeHi(modes['v'][2],     C.col.purple, C.col.black, true,  13, 15)
    C.MakeHi(modes['V'][2],     C.col.purple, C.col.black, true,  13, 15)
    C.MakeHi(modes[''][2],    C.col.purple, C.col.black, true,  13, 15)
    C.MakeHi(modes['s'][2],     C.col.purple, C.col.black, true,  13, 15)
    C.MakeHi(modes[''][2],    C.col.purple, C.col.black, true,  13, 15)
    C.MakeHi(modes['i'][2],     C.col.blue,   C.col.black, true,  12, 15)
    C.MakeHi(modes['ix'][2],    C.col.blue,   C.col.black, true,  12, 15)
    C.MakeHi(modes['R'][2],     C.col.red,    C.col.black, true,  1,  15)
    C.MakeHi(modes['Rv'][2],    C.col.red,    C.col.black, true,  1,  15)
    C.MakeHi(modes['c'][2],     C.col.yellow, C.col.black, true,  11, 15)
    C.MakeHi(modes['t'][2],     C.col.red,    C.col.black, true,  1,  15)
end

return C
