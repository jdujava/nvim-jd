local has_notify, notify_plugin = pcall(require, "notify")
if not has_notify then
    return
end

local log = require("plenary.log").new {
    plugin = "notify",
    level = "debug",
    use_console = false,
}

vim.notify = function(msg, level, opts)
    log.info(msg, level, opts)

    notify_plugin.notify(msg, level, opts)
end

notify_plugin.setup {
    background_colour = "#000000",
    top_down = false,
}

nmap { '<A-Space>', notify_plugin.dismiss, {silent=true} }
