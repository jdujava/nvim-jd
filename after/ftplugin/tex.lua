local keys_to_map = { "cs", "ds", "ts", "ci", "di", "vi", "yi", "ca", "da", "va", "ya" }

-- it is easier to hit "m" than "$"
for _, key in ipairs(keys_to_map) do
    vim.keymap.set("n", key .. "m", key .. "$", { buffer = true, remap = true })
end

-- beamer -- label and show only current slide
vim.keymap.set("n", "<leader><leader>c", [[mc:%s/,\s*label=current//e<CR>`c?frame<CR>f]i, label=current<ESC>`c]], { buffer = true})
vim.keymap.set("n", "<leader><leader>c", [[mc<CMD>%s/,\s*label=current//e<CR>`c?frame<CR>f]i, label=current<ESC>`c]])
vim.keymap.set("n", "<leader><leader>c", [[<CMD>exe "normal! mc:%s/,\s*label=current//e`c?framef]i, label=current`c"<CR>]])
