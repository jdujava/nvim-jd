local B = {}

local api = vim.api
local has_icons, icons = pcall(require, 'nvim-web-devicons')
local builder = require('jd.sl.builder')

B.buffers = {}
local ignore = {
    ["nofile"] = true,
    ["quickfix"] = true,
    ["prompt"] = true,
}

local function getBufLabel(n)
    local filename = vim.fn.fnamemodify(api.nvim_buf_get_name(n), ":t")
    if filename == '' then
        filename = "[No name]"
    end
    if has_icons then
        local icon = icons.get_icon(filename, nil, {default = true})
        filename = icon..' '..filename
    end
    if vim.bo[n].readonly then
        filename = filename.."[]"
    end
    if vim.bo[n].modified then
        filename = filename.."[+]"
    end
    return filename
end

function BufferLine()
    local current_buf = api.nvim_get_current_buf()
    B.buffers = api.nvim_list_bufs()           -- get all buffers
    B.buffers = vim.tbl_filter(function(b)     -- filter out only valid ones
        return api.nvim_buf_is_loaded(b) and not ignore[vim.bo[b].buftype]
    end, B.buffers)

    local bufferline = ''
    for _, b in pairs(B.buffers) do
        local bufHi = "SlBufferLine"..(b == current_buf and "Sel" or "")
        bufferline = bufferline..builder(bufHi,getBufLabel(b))
    end
    return bufferline
end

-- Buffer jumping
function B.jumpBuf(buf)
    if #B.buffers == 0 then
        return print "Err[BufferLine]: no buffers"
    end
    api.nvim_set_current_buf(B.buffers[math.min(#B.buffers,buf)])
end

for i=1,9 do
    map {'<A-'..i..'>', function() require'jd.sl.buffers'.jumpBuf(i) end}
end

return B
