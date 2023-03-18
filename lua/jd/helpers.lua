local M = {}

-- helper keymap functions (map, nmap, imap, ...)
for _,mode in ipairs({"", "i", "v", "n", "c", "t", "x", "o"}) do
    _G[mode.."map"] = function(tbl)
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

local enabled = true
function M.toggle_diagnostics()
  enabled = not enabled
  if enabled then
    vim.diagnostic.enable()
    require("lazy.core.util").info("Enabled diagnostics", { title = "Diagnostics" })
  else
    vim.diagnostic.disable()
    require("lazy.core.util").warn("Disabled diagnostics", { title = "Diagnostics" })
  end
end

return M
