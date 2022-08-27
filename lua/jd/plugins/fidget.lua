require('fidget').setup {
    window = {
        blend = 0,              -- &winblend for the window
    },
    text = {
        spinner = "moon",
    }
}

vim.api.nvim_set_hl(0, "FidgetTask", {bg = "#202020"})
