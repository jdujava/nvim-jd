local M = {}

-- helper keymap functions (map, nmap, imap, ...)
for _, mode in ipairs({ "", "i", "v", "n", "c", "t", "x", "o", "ia", "ca" }) do
    _G[mode .. "map"] = function(tbl)
        vim.keymap.set(mode, tbl[1], tbl[2], tbl[3])
    end
end

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach(client, buffer)
        end,
    })
end

---@param plugin string
function M.has(plugin)
    return require("lazy.core.config").plugins[plugin] ~= nil
end

function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

function M.R(module)
    package.loaded[module] = nil
    return require(module)
end

function M.toggle_diagnostics()
    vim.b.diagnostics_disabled = not vim.b.diagnostics_disabled
    if vim.b.diagnostics_disabled then
        vim.diagnostic.disable(0)
        require("lazy.core.util").warn("Disabled diagnostics", { title = "Diagnostics" })
    else
        vim.diagnostic.enable(0)
        require("lazy.core.util").info("Enabled diagnostics", { title = "Diagnostics" })
    end
end

return M
