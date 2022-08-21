-- Mode Prompt Table (mode-highlight)
local modes = {
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
    ['nt'] = {'NORMAL',    'SlNormal'},
}

return setmetatable(modes, {
    __index = function(_, k)
        print("Err[BufferLine]: fallback from '"..k.."' to 'n' mode")
        return {'NORMAL', 'SlNormal'} -- default value
    end
})
