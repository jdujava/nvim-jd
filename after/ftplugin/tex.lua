local keys_to_map = { "cs", "ds", "ts", "ci", "di", "vi", "yi", "ca", "da", "va", "ya" }

-- it is easier to hit "m" than "$"
for _, key in ipairs(keys_to_map) do
    vim.keymap.set("n", key .. "m", key .. "$", { buffer = 0, remap = true })
end
