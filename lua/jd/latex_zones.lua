local M = {}

-- zone captures defined in `after/queries/latex/highlights.scm`
-- function `get_zone` called in `after/python3/latex_zones.py`,
-- which provides helper python functions for UltiSnips snippets

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

---@param col_offset? number
---@return table[] captures List of captures `{ capture = "name", metadata = { ... } }`
local function get_captures(col_offset)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1 -- treesitter is 0-indexed
    col = col + (col_offset or 0)

    -- sometimes it is necessary to offset the column to get the correct node
    -- and not the next one, for example:
    --   % this is a comment| <- only `col_offset = -1` results in the comment node

    return vim.treesitter.get_captures_at_pos(0, row, col)
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
