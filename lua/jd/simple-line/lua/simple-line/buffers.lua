local B = {}

local has_icons, icons = pcall(require, 'nvim-web-devicons')
local builder = require('simple-line.builder')

B.buffers = {}
local ignore_buftype = {
    ['nofile'] = true,
    ['quickfix'] = true,
    ['prompt'] = true,
}
local noignore_filetype = {
    ['man'] = true,
    ['startuptime'] = true,
    ['checkhealth'] = true,
}

local function getBufLabel(n)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(n), ':t')
    if filename == '' then
        filename = '[No name]'
    end
    if has_icons then
        local icon = icons.get_icon(filename, nil, { default = true })
        filename = icon .. ' ' .. filename
    end
    filename = filename .. (vim.bo[n].readonly and '[]' or '')
    filename = filename .. (vim.bo[n].modified and '[+]' or '')
    return filename
end

function B.bufferLine()
    local current_buf = vim.api.nvim_get_current_buf()
    B.buffers = vim.api.nvim_list_bufs() -- get all buffers
    B.buffers = vim.tbl_filter(function(b) -- filter out only valid ones
        return vim.api.nvim_buf_is_loaded(b) and not ignore_buftype[vim.bo[b].buftype]
            or noignore_filetype[vim.bo[b].filetype]
    end, B.buffers)

    local bufferline = ''
    for _, b in pairs(B.buffers) do
        local bufHi = 'SlBufferLine' .. (b == current_buf and 'Sel' or '')
        bufferline = bufferline .. builder(bufHi, getBufLabel(b))
    end

    -- bufferline = bufferline.."%= lol"
    return bufferline
end

-- Buffer jumping
function B.jumpBuf(buf)
    if #B.buffers == 0 then
        return vim.notify('No buffers.', vim.log.levels.WARN, { title = 'BufferLine' })
    end
    vim.api.nvim_set_current_buf(B.buffers[math.min(#B.buffers, buf)])
end

for i = 1, 9 do
    vim.keymap.set({ 'n', 'v' }, '<A-' .. i .. '>', function()
        require('simple-line.buffers').jumpBuf(i)
    end, { desc = 'Jump to buffer ' .. i })
end

function B.setup()
    vim.o.showtabline = 2
    vim.o.tabline = [[%!v:lua.require'simple-line.buffers'.bufferLine()]]
end

return B
