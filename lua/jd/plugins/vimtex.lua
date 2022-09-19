-- nmap { '<Leader><Leader>p', [[:silent! exec '!praktikum & disown'<CR>:redraw!<CR>]], {silent=true}}

vim.g.vimtex_imaps_leader=";"
vim.g.tex_flavor='latex'
vim.g.vimtex_view_method='zathura'
vim.g.vimtex_quickfix_mode=0

vim.g.vimtex_fold_enabled = 1

vim.g.vimtex_syntax_conceal_disable = 1
-- vim.o.conceallevel = 2

vim.g.vimtex_matchparen_enabled = 0
-- vim.g.vimtex_delim_stopline=20
-- vim.g.matchup_matchparen_deferred = 1
-- vim.g.vimtex_delim_timeout=100
-- vim.g.vimtex_delim_insert_timeout=10

-- " hi texCmd ctermfg=1
-- " hi texArg ctermfg=140
-- " hi texOpt ctermfg=140
--
-- " hi texCmdParts ctermfg=140
-- " hi texPartArgTitle ctermfg=140
-- " hi texCmdTitle ctermfg=140
-- " hi texCmdAuthor ctermfg=140
-- " hi texTitleArg ctermfg=140
-- " hi texAuthorArg ctermfg=140
-- " hi texFootnoteArg ctermfg=140
--
-- " environments
-- " hi texCmdEnv ctermfg=12
-- " hi texEnvArgName ctermfg=4
-- " hi texEnvOpt ctermfg=140
--
-- " hi texMathZone ctermfg=12
-- " hi texMathDelim ctermfg=12
-- " hi texMathDelimZone ctermfg=12
-- " hi texMathCmd ctermfg=12
-- " hi texMathCmdEnv ctermfg=12
-- " hi texMathCmdEnvArgName ctermfg=4
-- " hi texCmdMathText ctermfg=140
-- " hi! link texCmdMathEnv  texMathCmdEnv
-- " hi texMathEnvArgName ctermfg=4
