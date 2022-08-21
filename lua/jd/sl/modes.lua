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
    ['ic'] = {'INSERT·c',  'SlInsertCompletion'},
    ['ix'] = {'INSERT·x',  'SlInsertCompletion'},
    ['R']  = {'Replace',   'SlReplace'},
    ['Rv'] = {'V·Replace', 'SlVirtualReplace'},
    ['c']  = {'COMMAND',   'SlCommand'},
    ['t']  = {'TERMINAL',  'SlTerm'},
    ['nt'] = {'NORMAL',    'SlNormal'},
}

return setmetatable(modes, {
    __index = function(_, k)
        vim.notify("[BufferLine]: Fallback from '"..k.."' to 'n' mode.", vim.log.levels.WARN)
        return {'NORMAL', 'SlNormal'} -- default value
    end
})
