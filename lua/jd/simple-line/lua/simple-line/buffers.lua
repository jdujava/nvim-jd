local B = {}

local has_icons, icons = pcall(require, 'nvim-web-devicons')
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

function B.bufferLine()
    update_buffers()

    local bufferline = {}
    local current_buf = vim.api.nvim_get_current_buf()
    for i, b in ipairs(B.buffers) do
        local bufHi = 'SlBufferLine' .. (b == current_buf and 'Sel' or '')
        table.insert(bufferline, '%' .. i .. "@v:lua.require'simple-line.buffers'.jumpBuf@")
        table.insert(bufferline, builder(bufHi, getBufLabel(b)))
        table.insert(bufferline, '%X')
    end

    table.insert(bufferline, '%=%#SlDirectorySeparator#')
    table.insert(bufferline, string.format('[%s/%d]', B.index_of_buf[current_buf] or '~', #B.buffers))

    -- vim.notify(table.concat(bufferline, '\n'))
    return table.concat(bufferline)
end

-- reordering buffers in bufferline
-- really update B.buffers table
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
    buf = math.min(#B.buffers, buf) -- make sure it's in range

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

function B.setup()
    vim.o.showtabline = 2
    vim.o.tabline = [[%!v:lua.require'simple-line.buffers'.bufferLine()]]

    local shift_number_keys = { '!', '@', '#', '$', '%', '^', '&', '*', '(', ')' }
    for i = 1, 9 do
        vim.keymap.set({ 'n', 'v' }, '<A-' .. i .. '>', function()
            require('simple-line.buffers').jumpBuf(i)
        end, { desc = 'Jump to buffer ' .. i })
        vim.keymap.set({ 'n', 'v' }, '<A-' .. shift_number_keys[i] .. '>', function()
            require('simple-line.buffers').moveBuf(i)
        end, { desc = 'Move buffer to index ' .. i })
    end

    vim.keymap.set({ 'n', 'v' }, '<A-Left>', function()
        require('simple-line.buffers').moveBuf(_, -1)
    end, { desc = 'Move buffer left' })
    vim.keymap.set({ 'n', 'v' }, '<A-Right>', function()
        require('simple-line.buffers').moveBuf(_, 1)
    end, { desc = 'Move buffer right' })
end

return B
