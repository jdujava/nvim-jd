local B = {}

local has_icons, mini_icons = pcall(require, 'mini.icons')
local builder = require('simple-line.builder')

B.buffers = {}
B.index_of_buf = {}

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
local name_by_filetype = setmetatable({
    ['checkhealth'] = 'checkhealth',
}, {
    __index = function(_, _)
        return '[No name]'
    end,
})

local function update_buffers()
    local buffers = vim.api.nvim_list_bufs()
    buffers = vim.tbl_filter(function(b)
        return vim.api.nvim_buf_is_loaded(b) and not ignore_buftype[vim.bo[b].buftype]
            or noignore_filetype[vim.bo[b].filetype]
    end, buffers)

    local new_index_of_buf = {}
    for i, b in ipairs(buffers) do
        new_index_of_buf[b] = i
    end

    -- update list of buffers, but retain previous order
    local still_exists = vim.tbl_filter(function(b)
        return new_index_of_buf[b] ~= nil
    end, B.buffers)
    local new_buffers = vim.tbl_filter(function(b)
        return B.index_of_buf[b] == nil
    end, buffers)
    B.buffers = vim.list_extend(still_exists, new_buffers)

    -- create buf_index table for quick access to buffer index
    B.index_of_buf = {}
    for i, b in ipairs(B.buffers) do
        B.index_of_buf[b] = i
    end

    -- vim.print(vim.inspect(require('simple-line.buffers').buffers) .. ' ' .. os.time())
end

local function getBufLabel(n)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(n), ':t')
    if filename == '' then
        filename = name_by_filetype[vim.bo[n].filetype]
    end
    if has_icons then
        local icon = mini_icons.get('file', filename)
        filename = icon .. ' ' .. filename
    end
    filename = filename .. (vim.bo[n].readonly and '[]' or '')
    filename = filename .. (vim.bo[n].modified and '[+]' or '')
    return filename
end

local click_callback = "@v:lua.require'simple-line.buffers'.jumpBuf@"
local function buf_entry(index, bufHi, bufLabel)
    return '%' .. index .. click_callback .. builder(bufHi, bufLabel) .. '%X'
end
local function truncate_entry(index)
    return '%' .. index .. click_callback .. '%#SlBufferLineSeparator#' .. vim.g.lsep .. '%#SlBufferLine# ...>%X'
end

local last_current_buf_index = 1

function B.bufferLine()
    update_buffers()

    local width = 0
    local max_width = vim.o.columns - 8

    local bufferline = {}
    local current_buf = vim.api.nvim_get_current_buf()
    local current_index = B.index_of_buf[current_buf] or last_current_buf_index
    last_current_buf_index = current_index

    for i, b in ipairs(B.buffers) do
        local bufHi = 'SlBufferLine' .. (b == current_buf and 'Sel' or '')
        local bufLabel = getBufLabel(b)
        width = width + vim.api.nvim_strwidth(bufLabel) + 5
        if width > max_width and i > current_index + 1 then
            table.insert(bufferline, truncate_entry(i))
            break
        end
        table.insert(bufferline, buf_entry(i, bufHi, bufLabel))
    end

    table.insert(bufferline, '%=%#SlDirectorySeparator# ')
    table.insert(bufferline, string.format('[%s/%d]', B.index_of_buf[current_buf] or '~', #B.buffers))

    -- vim.notify(table.concat(bufferline, '\n'))
    return table.concat(bufferline)
end

-- reordering buffers in bufferline
-- TODO: bp/bn doesn't respect the order
function B.moveBuf(index, dir)
    local current_buf = vim.api.nvim_get_current_buf()
    local current_index = B.index_of_buf[current_buf]
    if current_index == nil then
        return
    end
    local new_index = index or math.max(1, math.min(#B.buffers, current_index + dir))
    table.remove(B.buffers, current_index)
    table.insert(B.buffers, new_index, current_buf)
    vim.cmd.redrawtabline()
end

-- Buffer jumping, deleting, etc.
function B.jumpBuf(buf, _, button)
    if #B.buffers == 0 then
        return vim.notify('No buffers.', vim.log.levels.WARN, { title = 'BufferLine' })
    end
    if buf < 0 then -- negative index means from the end
        buf = #B.buffers + buf + 1
    end
    buf = math.max(1, math.min(#B.buffers, buf)) -- make sure it's in range

    button = button or 'l'
    if button == 'l' then
        vim.api.nvim_set_current_buf(B.buffers[buf])
    elseif button == 'r' then
        vim.cmd.edit('#')
    elseif button == 'm' then
        vim.cmd.bdelete(B.buffers[buf])
        vim.cmd.redrawtabline()
    end
end

function B.jumpBufNext(dir)
    local current_buf = vim.api.nvim_get_current_buf()
    local current_index = B.index_of_buf[current_buf]
    if current_index == nil then
        return
    end
    local new_index = math.max(1, math.min(#B.buffers, current_index + dir))
    vim.api.nvim_set_current_buf(B.buffers[new_index])
end

function B.setup()
    vim.o.showtabline = 2
    vim.o.tabline = [[%!v:lua.require'simple-line.buffers'.bufferLine()]]
    vim.api.nvim_set_hl(0, 'TabLineFill', { bg = 'None' })

    local shift_number_keys = { '!', '@', '#', '$', '%', '^', '&', '*', '(', ')' }
    for i = 1, 9 do
        vim.keymap.set({ 'n', 'v', 't' }, '<A-' .. i .. '>', function()
            require('simple-line.buffers').jumpBuf(i)
        end, { desc = 'Jump to buffer ' .. i })
        vim.keymap.set({ 'n', 'v', 't' }, '<A-' .. shift_number_keys[i] .. '>', function()
            require('simple-line.buffers').moveBuf(i)
        end, { desc = 'Move buffer to index ' .. i })
    end

    vim.keymap.set('n', ']b', function()
        require('simple-line.buffers').jumpBufNext(1)
    end, { desc = 'Jump to next buffer' })
    vim.keymap.set('n', '[b', function()
        require('simple-line.buffers').jumpBufNext(-1)
    end, { desc = 'Jump to prev buffer' })
    vim.keymap.set('n', '[B', function()
        require('simple-line.buffers').jumpBuf(1)
    end, { desc = 'Jump to first buffer' })
    vim.keymap.set('n', ']B', function()
        require('simple-line.buffers').jumpBuf(-1)
    end, { desc = 'Jump to last buffer' })

    vim.keymap.set({ 'n', 'v', 't' }, '<A-Left>', function()
        require('simple-line.buffers').moveBuf(false, -1)
    end, { desc = 'Move buffer left' })
    vim.keymap.set({ 'n', 'v', 't' }, '<A-Right>', function()
        require('simple-line.buffers').moveBuf(false, 1)
    end, { desc = 'Move buffer right' })
end

return B
