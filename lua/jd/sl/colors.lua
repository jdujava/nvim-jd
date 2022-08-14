local c = {}

local modes = require('jd.sl.data').modes

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

function c.MakeHi(higroup, gbg, gfg, gui, cbg, cfg, ct)
	vim.cmd('hi '..higroup..' guibg='..gbg..' guifg='..gfg..' gui='..gui..' ctermbg='..cbg..' ctermfg='..cfg..' cterm='..ct)
	vim.cmd('hi '..higroup..'Separator guibg=None guifg='..gbg)
end

function c.setStatusHi()
	c.MakeHi('SlDirectory',      bg,     white,  'bold', 0,  15, 'None')
	c.MakeHi('SlFiletype',       purple, black,  'bold', 13, 15, 'None')
	c.MakeHi('SlLine',           'None', white,  'bold', 15, 15, 'None')
	c.MakeHi('SlInActive',       black,  white,  'None', 15, 15, 'None')
	c.MakeHi('SlBufferLineSel',  green,  black,  'bold', 10, 15, 'None')
	c.MakeHi('SlBufferLine',     bg,     white,  'None', 15, 15, 'None')
	c.MakeHi(modes['n'][2],      green,  black,  'bold', 10, 15, 'None')
	c.MakeHi(modes['i'][2],      blue,   black,  'bold', 12, 15, 'None')
	c.MakeHi(modes['v'][2],      purple, black,  'bold', 13, 15, 'None')
	c.MakeHi(modes['V'][2],      purple, black,  'bold', 13, 15, 'None')
	c.MakeHi(modes[''][2],     purple, black,  'bold', 13, 15, 'None')
	c.MakeHi(modes['s'][2],      purple, black,  'bold', 13, 15, 'None')
	c.MakeHi(modes['c'][2],      yellow, black,  'bold', 11, 15, 'None')
	c.MakeHi(modes['t'][2],      red,    black,  'bold', 1,  15, 'None')
	c.MakeHi(modes['R'][2],      red,    black,  'bold', 1,  15, 'None')
end

-- set highlights on firt run
c.setStatusHi()

-- set highlights on colorscheme change
c.groupid = vim.api.nvim_create_augroup("StatusLine", {clear=true})
vim.api.nvim_create_autocmd(
	"ColorScheme",
	{
		callback=c.setStatusHi,
		group=c.groupid
	}
)

return c
