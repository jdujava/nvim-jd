local M = {}

-- inspired by https://github.com/nvim-treesitter/nvim-treesitter/issues/1184#issuecomment-1079844699

DEBUG = false

if DEBUG then
    vim.api.nvim_set_hl(0, '@zone.math', { link = '@diff.delta' })
    vim.api.nvim_set_hl(0, '@zone.comment', { link = '@diff.plus' })
    vim.api.nvim_set_hl(0, '@zone.text', { bg = '#1e1e1e' })
else
    vim.api.nvim_set_hl(0, '@zone.math', {})
    vim.api.nvim_set_hl(0, '@zone.text', {})
    vim.api.nvim_set_hl(0, '@zone.comment', {})
end

local MATH_NODES = {
    displayed_equation = true,
    inline_formula = true,
    math_environment = true,
}

local MATH_ENVIRONMENTS = {
    aligned = true,
}

local MATH_IGNORE = {
    text_mode = true,
    label_definition = true,
    label_reference = true,
}

local MATH_IGNORE_COMMANDS = {
    ['\\SI'] = true,
}

local COMMENT = {
    comment = true,
    line_comment = true,
    block_comment = true,
    comment_environment = true,
}

---@param col_offset? number
---@return TSNode|nil
local function get_node(col_offset)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1 -- treesitter is 0-indexed
    col = col + (col_offset or 0)

    -- col = col - 1 -- one character back to get the proper node and not the next one;
    -- % this is a comment| <- results in the comment node
    -- \( ... \)|           <- but this would result in the wrong node

    -- vim.print({ row, col }) -- DEBUG
    -- `ignore_injections = false` so that injections in gnuplot work
    return vim.treesitter.get_node({ pos = { row, col }, ignore_injections = false })
end

---@param node TSNode
---@return string|nil
local function get_environment(node)
    local node_text = vim.treesitter.get_node_text(node, 0)
    local first_line = vim.split(node_text, '\n')[1]
    if DEBUG then
        vim.notify(first_line)
    end
    return first_line:match('\\begin{([^}]+)}')
end

---@param node TSNode
---@return string|nil
local function get_command(node)
    local command = node:named_child(0) -- command_name field is always the first child (hopefully)
    -- local command1 = node:field("command")
    if command then
        vim.notify(vim.treesitter.get_node_text(command, 0))
        -- vim.notify(vim.treesitter.get_node_text(command1, 0))
        return vim.treesitter.get_node_text(command, 0)
    end
end

---@return boolean
function M.in_comment()
    local node = get_node(-1) -- one character back to get the proper node and not the next one
    while node do
        if COMMENT[node:type()] then
            return true
        end
        node = node:parent()
    end
    return false
end

---@return boolean
function M.in_mathzone()
    local node = get_node()
    while node do
        if DEBUG then
            vim.notify(node:type())
        end
        if MATH_IGNORE[node:type()] then
            return false
        elseif MATH_NODES[node:type()] then
            return true
        elseif node:type() == 'generic_command' and MATH_IGNORE_COMMANDS[get_command(node)] then
            return false
        elseif node:type() == 'generic_environment' and MATH_ENVIRONMENTS[get_environment(node)] then
            return true
        end
        node = node:parent()
    end
    return false
end

-- DIFFERENT APPROACH

---@param col_offset? number
---@return table[] List of captures `{ capture = "name", metadata = { ... } }`
local function get_captures(col_offset)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1 -- treesitter is 0-indexed
    col = col + (col_offset or 0)

    -- col = col - 1 -- one character back to get the proper node and not the next one;
    -- % this is a comment| <- results in the comment node
    -- \( ... \)|           <- but this would result in the wrong node

    local data = vim.treesitter.get_captures_at_pos(0, row, col)
    return data
    -- local captures = {}
    --
    -- for _, capture in ipairs(data) do
    --     table.insert(captures, capture.capture)
    -- end
    --
    -- return captures
end

---@param col_offset? number
function M.get_zone(col_offset)
    local captures = get_captures(col_offset)
    if DEBUG then
        vim.notify(vim.inspect(captures))
    end

    -- iterate through the captures from the last one to the first one
    -- and return the `type` of the first `zone.type` capture
    for i = #captures, 1, -1 do
        local capture = vim.split(captures[i].capture, '.', { plain = true })
        -- vim.notify(vim.inspect(capture))
        if capture[1] == 'zone' then
            return capture[2]
        end
    end
    return 'text'
end

return M
