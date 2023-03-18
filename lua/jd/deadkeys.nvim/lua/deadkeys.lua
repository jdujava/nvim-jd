local M = {}

local defaults = {
    enabled = true,
}

local keys = {
    ["'a"] = "á",
    ["'A"] = "Á",
    ["'e"] = "é",
    ["'E"] = "É",
    ["'i"] = "í",
    ["'I"] = "Í",
    ["'l"] = "ĺ",
    ["'L"] = "Ĺ",
    ["'o"] = "ó",
    ["'O"] = "Ó",
    ["'u"] = "ú",
    ["'U"] = "Ú",
    ["'y"] = "ý",
    ["'Y"] = "Ý",
    ["' "] = "'",

    ["[a"] = "ä",
    ["[A"] = "Ä",
    ["[c"] = "č",
    ["[C"] = "Č",
    ["[d"] = "ď",
    ["[D"] = "Ď",
    ["[e"] = "ě",
    ["[E"] = "Ě",
    ["[l"] = "ľ",
    ["[L"] = "Ľ",
    ["[n"] = "ň",
    ["[N"] = "Ň",
    ["[o"] = "ô",
    ["[O"] = "Ô",
    ["[r"] = "ř",
    ["[R"] = "Ř",
    ["[s"] = "š",
    ["[S"] = "Š",
    ["[t"] = "ť",
    ["[T"] = "Ť",
    ["[u"] = "ů",
    ["[U"] = "Ů",
    ["[z"] = "ž",
    ["[Z"] = "Ž",
    ["[ "] = "[",
}


function M.map(on)
    vim.b.deadkeys_on = on
    if on then
        for k, v in pairs(keys) do
            vim.keymap.set("i", k, v, { buffer = true })
        end
    else
        for k, _ in pairs(keys) do
            vim.keymap.del("i", k, { buffer = true })
        end
    end
end

function M.toggle()
    M.map(not vim.b.deadkeys_on)
    vim.notify("Deadkeys: " .. (vim.b.deadkeys_on and "on" or "off"), "info", { title = "Deadkeys" })
end

function M.setup(user_config)
    if user_config then
        defaults = vim.tbl_deep_extend("force", defaults, user_config)
    end

    if defaults.enabled then
        M.map(true)
        vim.api.nvim_create_autocmd({"BufReadPost","BufNewFile"}, {
            callback = function() M.map(true) end,
            group = vim.api.nvim_create_augroup("deadkeys", { clear = true }),
        })
    end
end

return M
