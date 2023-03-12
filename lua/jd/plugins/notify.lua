local has_notify, notify = pcall(require, "notify")
if not has_notify then
    return
end

local log = require("plenary.log").new {
    plugin = "notify",
    level = "debug",
    use_console = false,
}

---@diagnostic disable-next-line: duplicate-set-field
vim.notify = function(msg, level, opts)
    log.info(msg, level, opts)

    notify.notify(msg, level, opts)
end

notify.setup {
    background_colour = "#000000",
    top_down = false,
}

nmap { '<A-Space>', notify.dismiss, {silent=true} }
