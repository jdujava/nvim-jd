vim.cmd [[inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)]]

vim.cmd.cnoreabbrev "Bd bd"
vim.cmd.cnoreabbrev "Cp cp"
vim.cmd.cnoreabbrev "E e"
vim.cmd.cnoreabbrev "Sp sp"
vim.cmd.cnoreabbrev "SP sp"
vim.cmd.cnoreabbrev "Vs vs"
vim.cmd.cnoreabbrev "VS vs"
vim.cmd.cnoreabbrev "Q q"
vim.cmd.cnoreabbrev "Q! q!"
vim.cmd.cnoreabbrev "Qa qa"
vim.cmd.cnoreabbrev "QA qa"
vim.cmd.cnoreabbrev "QA! qa!"
vim.cmd.cnoreabbrev "W w"
vim.cmd.cnoreabbrev "W! w!"
vim.cmd.cnoreabbrev "Wq wq"
vim.cmd.cnoreabbrev "WQ wq"
vim.cmd.cnoreabbrev "Wqa wqa"
vim.cmd.cnoreabbrev "WQa wqa"
vim.cmd.cnoreabbrev "WQA wqa"
