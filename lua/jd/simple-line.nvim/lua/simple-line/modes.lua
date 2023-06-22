-- Mode Prompt Table (mode-highlight)
local modes = {
    ['n']    = {'NORMAL',     'SlNormal'},
    ['no']   = {'NORMAL',     'SlNormal'},
    ['nov']  = {'NORMAL',     'SlNormal'},
    ['noV']  = {'NORMAL',     'SlNormal'},
    ['no'] = {'NORMAL',     'SlNormal'},
    ['niI']  = {'NORMAL',     'SlNormal'},
    ['niR']  = {'NORMAL',     'SlNormal'},
    ['nt']   = {'NORMAL',     'SlNormal'},
    ['ntT']  = {'NORMAL',     'SlNormal'},
    ['v']    = {'VISUAL',     'SlVisual'},
    ['vs']   = {'VISUAL',     'SlVisual'},
    ['V']    = {'V·Line',     'SlVisualLine'},
    ['Vs']   = {'V·Line',     'SlVisualLine'},
    ['']   = {'V·Block',    'SlVisualBlock'},
    ['s']  = {'V·Block',    'SlVisualBlock'},
    ['s']    = {'Select',     'SlSelect'},
    ['S']    = {'S·Line',     'SlSLine'},
    ['']   = {'S·Block',    'SlSBlock'},
    ['i']    = {'INSERT',     'SlInsert'},
    ['ic']   = {'INSERT·c',   'SlInsertCompletion'},
    ['ix']   = {'INSERT·x',   'SlInsertCompletion'},
    ['R']    = {'Replace',    'SlReplace'},
    ['Rc']   = {'Replace·c',  'SlVirtualReplace'},
    ['Rx']   = {'Replace·x',  'SlVirtualReplace'},
    ['Rv']   = {'Replace·v',  'SlVirtualReplace'},
    ['Rvc']  = {'Replace·vc', 'SlVirtualReplace'},
    ['Rvx']  = {'Replace·vx', 'SlVirtualReplace'},
    ['c']    = {'COMMAND',    'SlCommand'},
    ['cv']   = {'COMMAND·ex', 'SlCommand'},
    ['r']    = {'TERMINAL',   'SlTerm'},
    ['rm']   = {'TERMINAL',   'SlTerm'},
    ['r?']   = {'TERMINAL',   'SlTerm'},
    ['!']    = {'TERMINAL',   'SlTerm'},
    ['t']    = {'TERMINAL',   'SlTerm'},
}

return setmetatable(modes, {
    __index = function(_, k)
        vim.notify("Fallback from '" .. k .. "' to 'n' mode.", vim.log.levels.WARN, { title = 'StatusLine' })
        -- pcall(vim.notify, "Fallback from '"..k.."' to 'n' mode.", vim.log.levels.WARN, {title = "StatusLine"})
        return { 'NORMAL', 'SlNormal' } -- default value
    end,
})
