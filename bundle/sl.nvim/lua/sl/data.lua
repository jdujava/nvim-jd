local data = {}

-- Mode Prompt Table (mode-highlight)
data.modes = {
	['n']  = {'NORMAL',    'SlNormal'},
	['v']  = {'VISUAL',    'SlVisual'},
	['V']  = {'V·Line',    'SlVisualLine'},
	[''] = {'V·Block',   'SlVisualBlock'},
	['s']  = {'Select',    'SlSelect'},
	['S']  = {'S·Line',    'SlSLine'},
	[''] = {'S·Block',   'SlSBlock'},
	['i']  = {'INSERT',    'SlInsert'},
	['ic'] = {'INSERT',    'SlInsertCompletion'},
	['ix'] = {'INSERT',    'SlInsertCompletion'},
	['R']  = {'Replace',   'SlReplace'},
	['Rv'] = {'V·Replace', 'SlVirtualReplace'},
	['c']  = {'COMMAND',   'SlCommand'},
	['t']  = {'TERMINAL',  'SlTerm'},
}

return data

-- local modes   = data.modes
-- local mode = vim.fn.mode()
-- print(modes[mode][2],modes[mode][1])
