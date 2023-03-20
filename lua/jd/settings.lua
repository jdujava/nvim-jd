vim.o.autochdir      = true
vim.o.cmdheight      = 0
vim.o.showmode       = false
vim.o.showmatch      = true
vim.o.number         = true
vim.o.relativenumber = true
vim.o.scrolloff      = 10
vim.o.sidescrolloff  = 8

vim.o.tabstop     = 4
vim.o.shiftwidth  = 4
vim.o.softtabstop = 4
vim.o.expandtab   = true
vim.o.cindent     = true
vim.o.breakindent = true
vim.o.showbreak   = '> '
vim.o.linebreak   = true

vim.o.ignorecase    = true
vim.o.smartcase     = true
vim.o.smartindent   = true
vim.o.foldmethod    = 'marker'
vim.o.foldmarker    = '{{{,}}}'
-- vim.o.foldmethod    = 'expr'
-- vim.o.foldexpr      = 'v:lua.vim.treesitter.foldexpr()'

vim.o.jumpoptions   = 'view'
vim.o.inccommand    = 'nosplit'
vim.o.virtualedit   = 'block'
vim.o.splitbelow    = true
vim.o.splitright    = true
vim.o.clipboard     = 'unnamedplus'
vim.o.completeopt   = 'menu,menuone,noselect'
vim.o.spelllang     = 'sk,en_us'
vim.o.signcolumn    = 'yes'
vim.o.mouse         = 'a'
vim.o.pumheight     = 15
vim.o.timeoutlen    = 500
vim.o.updatetime    = 200  -- Save swap file and trigger CursorHold
vim.o.backup        = true
vim.o.undofile      = true
vim.o.undolevels    = 10000
vim.o.backupdir     = vim.fn.stdpath("state") .. "/backup"
vim.o.shada         = [[!,'100,<50,s10,/100,:1000,h]]
vim.o.list          = true
vim.opt.listchars = {
    tab = "> ",
    trail = "_",
    extends = "»",
    precedes = "«",
    nbsp = "·",
}
vim.opt.fillchars = {
    vert = "│",
    foldopen = "",
    foldclose = "",
    fold = "·",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}
vim.opt.shortmess:append { I = true, c = true }

if vim.env.DISPLAY then
    vim.o.termguicolors = true
    vim.o.pumblend      = 5
end

vim.cmd.colorscheme 'noice'

-- TODO
-- do this !!!!!!!!!!
-- set diffopt+=linematch:60

-- vim.o.formatoptions:remove {"c", "r", "o"}
-- vim.o.formatoptions = opt.formatoptions
--   - "a" -- Auto formatting is BAD.
--   - "t" -- Don't auto format my code. I got linters for that.
--   + "c" -- In general, I like it when comments respect textwidth
--   + "q" -- Allow formatting comments w/ gq
--   - "o" -- O and o, don't continue comments
--   + "r" -- But do continue when pressing enter.
--   + "n" -- Indent past the formatlistpat, not underneath it.
--   + "j" -- Auto-remove comments if possible.
--   - "2" -- I'm not in gradeschool anymore


--TODO - diff colors ...

-- highlights
local hl = function(group, opts)
    opts.default = true
    vim.api.nvim_set_hl(0, group, opts)
end

-- Misc {{{
hl('@comment', {link = 'Comment'})
-- hl('@error', {link = 'Error'})
hl('@none', {bg = 'NONE', fg = 'NONE'})
hl('@preproc', {link = 'PreProc'})
hl('@define', {link = 'Define'})
hl('@operator', {link = 'Operator'})
-- }}}
-- Punctuation {{{
hl('@punctuation.delimiter', {link = 'Delimiter'})
hl('@punctuation.bracket', {link = 'Delimiter'})
hl('@punctuation.special', {link = 'Delimiter'})
-- }}}
-- Literals {{{
hl('@string', {link = 'String'})
hl('@string.regex', {link = 'String'})
hl('@string.escape', {link = 'SpecialChar'})
hl('@string.special', {link = 'SpecialChar'})

hl('@character', {link = 'Character'})
hl('@character.special', {link = 'SpecialChar'})

hl('@boolean', {link = 'Boolean'})
hl('@number', {link = 'Number'})
hl('@float', {link = 'Float'})
-- }}}
-- Functions {{{
hl('@function', {link = 'Function'})
hl('@function.call', {link = 'Function'})
hl('@function.builtin', {link = 'Special'})
hl('@function.macro', {link = 'Macro'})

hl('@method', {link = 'Function'})
hl('@method.call', {link = 'Function'})

hl('@constructor', {link = 'Special'})
hl('@parameter', {link = 'Identifier'})
-- }}}
-- Keywords {{{
hl('@keyword', {link = 'Keyword'})
hl('@keyword.function', {link = 'Keyword'})
hl('@keyword.operator', {link = 'Keyword'})
hl('@keyword.return', {link = 'Keyword'})

hl('@conditional', {link = 'Conditional'})
hl('@repeat', {link = 'Repeat'})
hl('@debug', {link = 'Debug'})
hl('@label', {link = 'Label'})
hl('@include', {link = 'Include'})
hl('@exception', {link = 'Exception'})
-- }}}
-- Types {{{
hl('@type', {link = 'Type'})
hl('@type.builtin', {link = 'Type'})
hl('@type.qualifier', {link = 'Type'})
hl('@type.definition', {link = 'Typedef'})

hl('@storageclass', {link = 'StorageClass'})
hl('@attribute', {link = 'PreProc'})
hl('@field', {link = 'Identifier'})
hl('@property', {link = 'Identifier'})
-- }}}
-- Identifiers {{{
hl('@variable', {link = 'Normal'})
hl('@variable.builtin', {link = 'Special'})

hl('@constant', {link = 'Constant'})
hl('@constant.builtin', {link = 'Special'})
hl('@constant.macro', {link = 'Define'})

hl('@namespace', {link = 'Include'})
hl('@symbol', {link = 'Identifier'})
-- }}}
-- Text {{{
hl('@text', {link = 'Normal'})
hl('@text.strong', {bold = true})
hl('@text.emphasis', {italic = true})
hl('@text.underline', {underline = true})
hl('@text.strike', {strikethrough = true})
hl('@text.title', {link = 'Title'})
hl('@text.literal', {link = 'String'})
hl('@text.uri', {link = 'Underlined'})
hl('@text.math', {link = 'Special'})
hl('@text.environment', {link = 'Macro'})
hl('@text.environment.name', {link = 'Type'})
hl('@text.reference', {link = 'Constant'})

-- hl('@text.diff.add.diff', {link = 'DiffAdd'})
-- hl('@text.diff.delete.diff', {link = 'DiffDelete'})
-- hl('@text.diff.change.diff', {link = 'DiffChange'})

hl('@text.todo', {link = 'Todo'})
hl('@text.note', {link = 'SpecialComment'})
hl('@text.warning', {link = 'WarningMsg'})
hl('@text.danger', {link = 'ErrorMsg'})
-- }}}
-- Tags {{{
hl('@tag', {link = 'Tag'})
hl('@tag.attribute', {link = 'Identifier'})
hl('@tag.delimiter', {link = 'Delimiter'})
hl('@neorg.tags.ranged_verbatim.code_block', {bg = "#1c1c1c"})
-- }}}
