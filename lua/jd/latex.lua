local M = {}

-- inspired by https://github.com/nvim-treesitter/nvim-treesitter/issues/1184#issuecomment-1079844699

DEBUG = false

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
        elseif node:type() == 'generic_environment' and MATH_ENVIRONMENTS[get_environment(node)] then
            return true
        end
        node = node:parent()
    end
    return false
end

return M
