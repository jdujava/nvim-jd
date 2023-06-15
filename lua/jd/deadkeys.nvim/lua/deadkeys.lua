local Util = require("lazy.core.util")

local M = {}

M.defaults = {
    enabled = true,
}

M.keys = {
    ["' "] = "'", ["[ "] = "[",
    ["'a"] = "á", ["'A"] = "Á",
    ["'e"] = "é", ["'E"] = "É",
    ["'i"] = "í", ["'I"] = "Í",
    ["'l"] = "ĺ", ["'L"] = "Ĺ",
    ["'o"] = "ó", ["'O"] = "Ó",
    ["'u"] = "ú", ["'U"] = "Ú",
    ["'y"] = "ý", ["'Y"] = "Ý",
    ["[a"] = "ä", ["[A"] = "Ä",
    ["[c"] = "č", ["[C"] = "Č",
    ["[d"] = "ď", ["[D"] = "Ď",
    ["[e"] = "ě", ["[E"] = "Ě",
    ["[l"] = "ľ", ["[L"] = "Ľ",
    ["[n"] = "ň", ["[N"] = "Ň",
    ["[o"] = "ô", ["[O"] = "Ô",
    ["[r"] = "ř", ["[R"] = "Ř",
    ["[s"] = "š", ["[S"] = "Š",
    ["[t"] = "ť", ["[T"] = "Ť",
    ["[u"] = "ů", ["[U"] = "Ů",
    ["[z"] = "ž", ["[Z"] = "Ž",
}


function M.map()
    vim.b.deadkeys_on = true
    for k, v in pairs(M.keys) do
        vim.keymap.set("i", k, v, { buffer = true })
    end
end

function M.unmap()
    vim.b.deadkeys_on = false
    for k, _ in pairs(M.keys) do
        vim.keymap.del("i", k, { buffer = true })
    end
end

function M.toggle()
    if vim.b.deadkeys_on then
        M.unmap()
        Util.warn("Disabled deadkey mappings", { title = "Deadkeys" })
    else
        M.map()
        Util.info("Enabled deadkey mappings", { title = "Deadkeys" })
    end
end

function M.setup(user_config)
    if user_config then
        M.defaults = vim.tbl_deep_extend("force", M.defaults, user_config)
    end

    if M.defaults.enabled then
        M.map()
        vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
            group = vim.api.nvim_create_augroup("deadkeys", {}),
            callback = M.map,
        })
    end
end

return M
